const { createApp, ref } = Vue;

const app = createApp({
  setup() {
    const fileInput = ref(null);
    const audio = ref(null);
    const fileName = ref('');
    const fileUrl = ref('');
    const playing = ref(false);
    const progress = ref(0);

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
    };

    const togglePlay = () => {
      if (audio.value.paused) {
        audio.value.play();
      } else {
        audio.value.pause();
      }
    };

    const updateProgress = () => {
      if (audio.value.duration) {
        progress.value = (audio.value.currentTime / audio.value.duration) * 100;
      }
    };

    return { fileInput, audio, fileName, fileUrl, playing, progress, openFile, onFileChange, togglePlay, updateProgress };
  }
});

app.use(ElementPlus);
app.mount('#app');
