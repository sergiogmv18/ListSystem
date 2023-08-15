import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';

/// A singleton that handles the translations and Locale operations
class TranslateController extends ChangeNotifier {
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('pt', 'BR'),
  ];
  
  static final TranslateController _instance = TranslateController._();
  static String get localeTag => localeStatic.toString();
  static Locale? localeStatic;
  static String get formattedLocaleTag => formatLocaleToDbString(localeTag);
  Locale? get locale => localeStatic;
  String? defaultLocale;
  bool? withTranslations;

  Translations _translations = Translations('en');

  TranslateController._() {
    withTranslations = false;
  }

  factory TranslateController.getInstance() => _instance;

  Future<void> loadTranslations() async {
    notifyListeners();
    _translations = Translations('placeholder');

    List translationJson = json.decode(await rootBundle.loadString('assets/translate.json'));
    for (Map translationElement in translationJson) {
      Map<String, String> tmp = translationElement.cast<String, String>();
      _translations += tmp;
    }
    notifyListeners();
  }

  /// Translates [text] by looking up to corresponding
  String translate(String text, [Locale? locale]) {
    Locale? languageCode;
    if (locale != null) {
      languageCode = locale;
    } else {
      languageCode = localeStatic;
    }
    return localize(text, _translations, locale: languageCode.toString());
  }

  /// Converts the locale string to the format used in TranslationEntry database table
  static String formatLocaleToDbString(String localeTag) {
    return localeTag.replaceAll(RegExp('[^A-Za-z]'), '').toLowerCase();
  }

  /// Converts the locale string used in the TranslationEntry database table to the conventional format
  static String formatDbStringToLocale(String dbString) {
    if (dbString.length != 2 && dbString.length != 4) {
      return null.toString();
    }
    return dbString.replaceAllMapped(RegExp(r'([A-Z]\w)'), (Match m) => '_${m[0]!.toUpperCase()}');
  }
}

class TranslationDelegate extends LocalizationsDelegate<TranslateController> {
  const TranslationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pt' ].contains(locale.languageCode);

  @override
  Future<TranslateController> load(Locale locale) async {
    TranslateController translation = TranslateController.getInstance();
    if(TranslateController.localeStatic != null){
      return translation;
    }
    // await AppDatabase.getInstance().initializeDatabase();
    await translation.loadTranslations();
    TranslateController.localeStatic = locale;
    return translation;
  }

  /*
   * load last application language
   * Obs: this method is used to load translations in background and when app receive firebase message
   * @author SGV
   * @version 1.0 - 20230814 - initial release
   * @return  void
   */
  Future<void> loadLastApplicationLanguage() async {
    if(TranslateController.localeStatic == null || TranslateController.localeStatic.toString() == "null"){
      String lastApplicationLanguage = 'en';
      await load(Locale.fromSubtags(languageCode: lastApplicationLanguage));
    }
  }

  @override
  bool shouldReload(TranslationDelegate old) => false;
}

/*
 * Check the first letter in case estella lowercase will be changed to uppercase
 * @author  SGV - 20230814
 * @version 1.0 - 20230814 - initial release
 * @return  first capital letter
 */
extension CapExtension on String {
  String get inCaps => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ");
}

/// Wrapper function for [TranslationController.translate], with the option to capitalize first letter
String translate(String text, {bool capitilize = true, Locale? locale}) {
 
  String resultText = '';
  if (capitilize) {
    resultText = TranslateController.getInstance().translate(text, locale).inCaps;
  } else {
    resultText = TranslateController.getInstance().translate(text, locale);
  }
  return (resultText != '' && resultText != '%' ? resultText : (capitilize ? "! " + text.inCaps : "! " + text));
}




