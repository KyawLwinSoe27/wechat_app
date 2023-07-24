import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppLifecycleState { resumed, paused }

class AppLifecycleObserver {
  final Function(AppLifecycleState) onAppLifecycleChange;

  AppLifecycleObserver(this.onAppLifecycleChange);

  void addObserver() {
    WidgetsBinding.instance?.addObserver(_lifecycleHandler as WidgetsBindingObserver);
  }

  void removeObserver() {
    WidgetsBinding.instance?.removeObserver(_lifecycleHandler as WidgetsBindingObserver);
  }

  void _lifecycleHandler(AppLifecycleState state) {
    onAppLifecycleChange(state);
  }
}
