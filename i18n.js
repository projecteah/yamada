const messages = {
  en: {
    subtitle: 'Local music player',
    openFiles: 'Open Files',
    name: 'Name',
    play: 'Play',
    pause: 'Pause',
    prev: 'Prev',
    next: 'Next',
    repeatOff: 'Repeat: Off',
    repeatAll: 'Repeat: All',
    repeatOne: 'Repeat: One',
    darkMode: 'Dark',
    lightMode: 'Light',
    noFile: 'No file loaded.'
  }
};

const i18n = {
  locale: 'en',
  t(key) {
    return messages[this.locale]?.[key] || messages.en[key] || key;
  },
  setLocale(val) {
    this.locale = val;
  }
};
