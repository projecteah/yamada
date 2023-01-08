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
  },
  'zh-Hans-CN': {
    subtitle: '本地音乐播放器',
    openFiles: '打开文件',
    name: '名称',
    play: '播放',
    pause: '暂停',
    prev: '上一首',
    next: '下一首',
    repeatOff: '循环：关闭',
    repeatAll: '循环：列表',
    repeatOne: '循环：单曲',
    darkMode: '深色',
    lightMode: '浅色',
    noFile: '未加载文件。'
  },
  'zh-Hant-TW': {
    subtitle: '本地音樂播放器',
    openFiles: '開啟檔案',
    name: '名稱',
    play: '播放',
    pause: '暫停',
    prev: '上一首',
    next: '下一首',
    repeatOff: '循環：關閉',
    repeatAll: '循環：列表',
    repeatOne: '循環：單曲',
    darkMode: '深色',
    lightMode: '淺色',
    noFile: '未載入檔案。'
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
