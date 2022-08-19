import 'package:flutter/material.dart';

import '../../features/localization/locale/app_localizations.dart';
import '../error/exceptions.dart';
import '../../resources/strings_manager.dart';

extension TranslateX on String {
  String tr(BuildContext context) {
    try {
      String result = AppLocalizations.of(context)!.translate(this);
      return result;
    } on TranslateException {
      debugPrint(StringsManager.wordTranslationNotFound);
      return '';
    }
  }
}
