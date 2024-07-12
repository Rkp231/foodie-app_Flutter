import 'package:flutter/material.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/data/models/user.dart';
import 'package:foodie/data/repositories/auth.repository.dart';
import 'package:foodie/viewmodels/base.viewmodel.dart';
import 'package:foodie/widgets/language_selector.view.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileViewModel extends MyBaseViewModel {
  //
  User user;
  AuthRepository _authRepository = AuthRepository();

  ProfileViewModel(BuildContext context) {
    this.viewContext = context;
  }

  initialise() async {
    setBusy(true);
    user = await _authRepository.appDatabase.userDao.findCurrent();
    setBusy(false);
  }

  //
  changeLanguage() async {
    showModalBottomSheet(
      context: viewContext,
      builder: (context) {
        return AppLanguageSelector(
          onSelected: (code) async {
            await AuthBloc.prefs.setString(AppStrings.localeKey, code);            
            I18n.of(viewContext).locale = Locale(code ?? "en");
            viewContext.pop();
          },
        );
      },
    );
  }

  //
  void processLogout() async {
    //
    await _authRepository.logout();
    user = null;
    notifyListeners();
  }
}
