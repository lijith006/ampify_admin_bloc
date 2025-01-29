import 'package:ampify_admin_bloc/themes/dark_mode.dart';
import 'package:ampify_admin_bloc/themes/light_mode.dart';
// import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeData> {
  ThemeCubit() : super(lightMode);
//toggle
  void toggleTheme(bool isDarkMode) {
    emit(isDarkMode ? darkMode : lightMode);
  }

  @override
  ThemeData fromJson(Map<String, dynamic> json) {
    return json['isDarkMode'] as bool ? darkMode : lightMode;
  }

  @override
  Map<String, dynamic> toJson(ThemeData state) {
    return {'isDarkMode': state == darkMode};
  }
}
