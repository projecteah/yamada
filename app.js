const { createApp, ref } = Vue;

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

    const openFile = () => {
      fileInput.value.click();
    };

    const onFileChange = (e) => {
      const file = e.target.files[0];
      if (!file) return;

      fileName.value = file.name;

      if (fileUrl.value) {
        URL.revokeObjectURL(fileUrl.value);
      }

      fileUrl.value = URL.createObjectURL(file);
      playing.value = false;
      progress.value = 0;
      currentTime.value = 0;
      duration.value = 0;
    };

    const togglePlay = () => {
      if (audio.value.paused) {
        audio.value.play();
      } else {
        audio.value.pause();
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

    return { fileInput, audio, fileName, fileUrl, playing, progress, currentTime, duration, volume, openFile, onFileChange, togglePlay, updateProgress, seek, setVolume, formatTime };
  }
});

app.use(ElementPlus);
app.mount('#app');
