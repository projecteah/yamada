import 'dart:ui';

final appName = 'Yamada';

class Language {
  final Locale locale;
  final String label;

  const Language(this.locale, this.label);
}

const kLanguages = <Language>[
  Language(Locale('en'), 'English'),
  Language(Locale('es'), 'Español'),
  Language(Locale('pt'), 'Português'),
  Language(
    Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    'Português do Brasil',
  ),
  Language(Locale('ja'), '日本語'),
  Language(
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
    '简体中文',
  ),
  Language(
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
    '正體中文',
  ),
  // Language(
  //   Locale.fromSubtags(languageCode: 'yue'),
  //   '廣東話',
  // ),
  // Language(
  //   Locale.fromSubtags(languageCode: 'lzh'),
  //   '文言',
  // ),
];

final supportedLocales = kLanguages.map((l) => l.locale).toList();
