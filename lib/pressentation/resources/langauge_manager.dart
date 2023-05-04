import 'package:flutter/cupertino.dart';

enum LanguageType { ENGLISH, ARABIC }

const String ARABIC = 'ar';
const String ENGLISH = 'en';
const String ASSET_PATH_LOCALISATTIONS = 'assets/translations';

const Locale ARABIC_LOCAL = Locale('ar', 'SA');
const Locale ENGLISH_LOCAL = Locale('en', 'US');

extension LanguageTypeExtention on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}
