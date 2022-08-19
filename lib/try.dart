import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslny_user/core/extensions/string_extension.dart';
import 'package:waslny_user/resources/font_manager.dart';

import 'features/localization/locale/app_localizations.dart';
import 'features/localization/presentation/cubits/localization_cubit.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'try_again'.tr(context),
          style: const TextStyle(fontSize: FontSize.s32),
        ),
        OutlinedButton(
          child: const Text('change to english'),
          onPressed: () {
            BlocProvider.of<LocalizationCubit>(context)
                .setLocale(const Locale('en'));
          },
        ),
        OutlinedButton(
          child: const Text('change to Arabic'),
          onPressed: () {
            BlocProvider.of<LocalizationCubit>(context)
                .setLocale(const Locale('ar'));
          },
        ),
      ],
    ));
  }
}
