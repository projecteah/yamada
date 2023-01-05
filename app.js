const { createApp, ref, computed } = Vue;

const app = createApp({
  setup() {
    const fileInput = ref(null);
    const audio = ref(null);
    const fileName = ref('');
    const fileUrl = ref('');
    const playing = ref(false);
    const progress = ref(0);
    const currentTime = ref(0);
    const duration = ref(0);
    const volume = ref(100);
    const playlist = ref([]);
    const currentIndex = ref(0);

    const hasPrev = computed(() => currentIndex.value > 0);
    const hasNext = computed(() => currentIndex.value < playlist.value.length - 1);

    const openFile = () => {
      fileInput.value.click();
    };

    const onFileChange = (e) => {
      const files = Array.from(e.target.files);
      if (!files.length) return;

      files.forEach(f => {
        playlist.value.push({ name: f.name, url: URL.createObjectURL(f) });
      });

      if (!fileUrl.value) {
        loadTrack(0);
      }
    };

    const loadTrack = (i) => {
      if (fileUrl.value) {
        URL.revokeObjectURL(fileUrl.value);
      }

      currentIndex.value = i;

      const track = playlist.value[i];
      fileName.value = track.name;
      fileUrl.value = track.url;
      playing.value = false;
      progress.value = 0;
      currentTime.value = 0;
      duration.value = 0;
    };

    const playIndex = (row) => {
      const i = playlist.value.findIndex(t => t.name === row.name);
      loadTrack(i);
    };

    const togglePlay = () => {
      if (audio.value.paused) {
        audio.value.play();
      } else {
        audio.value.pause();
      }
    };

    const prev = () => {
      if (hasPrev.value) {
        loadTrack(currentIndex.value - 1);
      }
    };

    const next = () => {
      if (hasNext.value) {
        loadTrack(currentIndex.value + 1);
      }
    };

    const updateProgress = () => {
      currentTime.value = audio.value.currentTime;

      if (audio.value.duration) {
        progress.value = (audio.value.currentTime / audio.value.duration) * 100;
      }
    };

    const seek = (e) => {
      const rect = e.currentTarget.getBoundingClientRect();
      const pct = (e.clientX - rect.left) / rect.width;
      audio.value.currentTime = pct * audio.value.duration;
    };

    const setVolume = () => {
      audio.value.volume = volume.value / 100;
    };

    const formatTime = (s) => {
      if (!s) return '0:00';
      const m = Math.floor(s / 60);
      const sec = Math.floor(s % 60);
      return m + ':' + (sec < 10 ? '0' : '') + sec;
    };

    return { fileInput, audio, fileName, fileUrl, playing, progress, currentTime, duration, volume, playlist, hasPrev, hasNext, openFile, onFileChange, playIndex, togglePlay, prev, next, updateProgress, seek, setVolume, formatTime };
  }
});

app.use(ElementPlus);
app.mount('#app');
