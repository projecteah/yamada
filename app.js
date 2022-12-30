const { createApp, ref } = Vue;

const app = createApp({
  setup() {
    const fileInput = ref(null);
    const audio = ref(null);
    const fileName = ref('');
    const fileUrl = ref('');
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
    };
    return { fileInput, audio, fileName, fileUrl, openFile, onFileChange };
  }
});

app.use(ElementPlus);
app.mount('#app');
