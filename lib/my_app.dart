import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waslny_user/features/localization/presentation/cubits/localization_cubit.dart';
import 'package:waslny_user/resources/strings_manager.dart';
import 'package:waslny_user/try.dart';

import 'features/localization/locale/app_localizations_setup.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LocalizationCubit>()..getLocale()),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'AppStrings.appName',
            debugShowCheckedModeBanner: false,
            // theme: appTheme(),
            // onGenerateRoute: AppRoutes.onGenerateRoute,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            locale: BlocProvider.of<LocalizationCubit>(context).selectedLocale,
            // localeResolutionCallback:
            //     AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            home: Scaffold(
              body: Test(),
            ),
          );
        },
      ),
    );
  }
}
