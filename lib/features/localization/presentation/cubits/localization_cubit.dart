import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:waslny_user/core/usecases/usecase.dart';
import 'package:waslny_user/features/localization/domain/usecases/get_locale_use_case.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/local_entity.dart';
import '../../domain/usecases/set_locale_use_case.dart';
import '../../locale/app_localizations_setup.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final GetLocaleUseCase getLocaleUseCase;
  final SetLocaleUseCase setLocaleUseCase;

  LocalizationCubit({
    required this.getLocaleUseCase,
    required this.setLocaleUseCase,
  }) : super(LocalizationInitial());

  late Locale selectedLocale;

  getLocale() {
    final Either<Failure, LocaleEntity> successOrFailure =
        getLocaleUseCase(NoParams());

    successOrFailure.fold((failure) {
      selectedLocale = AppLocalizationsSetup.supportedLocales.first;
    }, (success) {
      selectedLocale = success.locale;
    });
  }

  Future setLocale(Locale locale) async {
    final Either<Failure, Unit> successOrFailure =
        await setLocaleUseCase(LocaleEntity(locale: locale));

    successOrFailure.fold(
      (failure) {
        emit(const LocalizationErrorState(errorMsg: "localizationError"));
      },
      (success) {
        selectedLocale = locale;
        emit(LocalizationSuccessState(locale: locale));
      },
    );
  }
}
