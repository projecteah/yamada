<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useI18n } from 'vue-i18n'

const { t, locale } = useI18n()

const fileInput = ref<HTMLInputElement | null>(null)
const audio = ref<HTMLAudioElement | null>(null)
const fileName = ref('')
const fileUrl = ref('')
const playing = ref(false)
const progress = ref(0)
const currentTime = ref(0)
const duration = ref(0)
const volume = ref(100)
const playlist = ref<{ name: string; url: string }[]>([])
const currentIndex = ref(0)
const repeatMode = ref<'none' | 'all' | 'one'>('none')
const isDark = ref(false)

const hasPrev = computed(() => currentIndex.value > 0)
const hasNext = computed(() => currentIndex.value < playlist.value.length - 1)

const cycleRepeat = () => {
  const modes: ('none' | 'all' | 'one')[] = ['none', 'all', 'one']
  const i = modes.indexOf(repeatMode.value)
  repeatMode.value = modes[(i + 1) % 3]
}

const toggleDark = (val: boolean) => {
  document.documentElement.classList.toggle('dark', val)
  localStorage.setItem('yamada-dark', String(val))
}

const openFile = () => {
  fileInput.value?.click()
}

const onFileChange = (e: Event) => {
  const files = Array.from((e.target as HTMLInputElement).files || [])
  if (!files.length) return

  files.forEach(f => {
    playlist.value.push({ name: f.name, url: URL.createObjectURL(f) })
  })

  if (!fileUrl.value) {
    loadTrack(0)
  }
}

const loadTrack = (i: number) => {
  if (fileUrl.value) {
    URL.revokeObjectURL(fileUrl.value)
  }
  currentIndex.value = i
  const track = playlist.value[i]
  fileName.value = track.name
  fileUrl.value = track.url
  playing.value = false
  progress.value = 0
  currentTime.value = 0
  duration.value = 0
}

const playIndex = (row: { name: string }) => {
  const i = playlist.value.findIndex(t => t.name === row.name)
  loadTrack(i)
}

const togglePlay = () => {
  if (audio.value?.paused) {
    audio.value.play()
  } else {
    audio.value?.pause()
  }
}

const prev = () => {
  if (hasPrev.value) {
    loadTrack(currentIndex.value - 1)
  }
}

const next = () => {
  if (hasNext.value) {
    loadTrack(currentIndex.value + 1)
  }
}

const onEnded = () => {
  if (repeatMode.value === 'one') {
    if (audio.value) audio.value.currentTime = 0
    audio.value?.play()
  } else if (repeatMode.value === 'all' && hasNext.value) {
    loadTrack(currentIndex.value + 1)
    audio.value?.play()
  } else if (repeatMode.value === 'all' && !hasNext.value && playlist.value.length > 0) {
    loadTrack(0)
    audio.value?.play()
  }
}

const updateProgress = () => {
  if (!audio.value) return
  currentTime.value = audio.value.currentTime
  if (audio.value.duration) {
    progress.value = (audio.value.currentTime / audio.value.duration) * 100
  }
}

const seek = (e: MouseEvent) => {
  const rect = (e.currentTarget as HTMLElement).getBoundingClientRect()
  const pct = (e.clientX - rect.left) / rect.width
  if (audio.value) {
    audio.value.currentTime = pct * audio.value.duration
  }
}

const setVolume = () => {
  if (audio.value) {
    audio.value.volume = volume.value / 100
  }
}

const formatTime = (s: number): string => {
  if (!s) return '0:00'
  const m = Math.floor(s / 60)
  const sec = Math.floor(s % 60)
  return m + ':' + (sec < 10 ? '0' : '') + sec
}

const repeatLabel = (): string => {
  const key = { none: 'repeatOff', all: 'repeatAll', one: 'repeatOne' }[repeatMode.value]
  return t(key)
}

const handleKeydown = (e: KeyboardEvent) => {
  if (e.code === 'Space') {
    e.preventDefault()
    togglePlay()
  } else if (e.code === 'ArrowLeft') {
    prev()
  } else if (e.code === 'ArrowRight') {
    next()
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleKeydown)
})

onUnmounted(() => {
  document.removeEventListener('keydown', handleKeydown)
})
</script>

<template>
  <el-container>
    <el-header class="flex items-center gap-3">
      <span class="text-xl font-semibold">Yamada</span>
      <span class="text-sm text-gray-500">{{ t('subtitle') }}</span>
      <el-select v-model="locale" size="small" class="w-28 ml-auto">
        <el-option label="English" value="en" />
        <el-option label="简体中文" value="zh-Hans-CN" />
        <el-option label="繁體中文" value="zh-Hant-TW" />
        <el-option label="文言" value="lzh" />
      </el-select>
      <el-switch v-model="isDark" @change="toggleDark" />
    </el-header>
    <el-main>
      <el-button type="primary" @click="openFile">{{ t('openFiles') }}</el-button>
      <input type="file" ref="fileInput" accept="audio/*" multiple class="hidden" @change="onFileChange">
      <div v-if="playlist.length" class="mt-4">
        <el-table :data="playlist" size="small" @row-click="playIndex" highlight-current-row>
          <el-table-column prop="name" :label="t('name')" />
        </el-table>
      </div>
      <div v-if="fileUrl" class="mt-4">
        <p v-if="fileName">{{ fileName }}</p>
        <el-button @click="togglePlay">{{ playing ? t('pause') : t('play') }}</el-button>
        <el-button @click="prev" :disabled="!hasPrev">{{ t('prev') }}</el-button>
        <el-button @click="next" :disabled="!hasNext">{{ t('next') }}</el-button>
        <el-button @click="cycleRepeat">{{ repeatLabel() }}</el-button>
        <div class="flex items-center gap-2 mt-3">
          <span class="text-xs text-gray-500 min-w-10">{{ formatTime(currentTime) }}</span>
          <el-progress :percentage="progress" :stroke-width="4" class="flex-1 cursor-pointer" @click="seek" />
          <span class="text-xs text-gray-500 min-w-10">{{ formatTime(duration) }}</span>
        </div>
        <div class="flex items-center gap-2 mt-3">
          <span class="text-xs text-gray-500">Vol</span>
          <el-slider v-model="volume" :show-tooltip="false" @input="setVolume" class="flex-1" />
        </div>
        <audio
          :src="fileUrl"
          ref="audio"
          @play="playing = true"
          @pause="playing = false"
          @timeupdate="updateProgress"
          @loadedmetadata="duration = audio!.duration"
          @ended="onEnded"
        />
      </div>
    </el-main>
  </el-container>
</template>
