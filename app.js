const { createApp, ref } = Vue;

const app = createApp({
  setup() {
    const fileInput = ref(null);
    const audio = ref(null);
    const fileName = ref('');
    const fileUrl = ref('');
    const playing = ref(false);

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
    };

    const togglePlay = () => {
      if (audio.value.paused) {
        audio.value.play();
      } else {
        audio.value.pause();
      }
    };

    return { fileInput, audio, fileName, fileUrl, playing, openFile, onFileChange, togglePlay };
  }
});

app.use(ElementPlus);
app.mount('#app');
