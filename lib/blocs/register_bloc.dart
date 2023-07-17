import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class RegisterBloc extends ChangeNotifier {
  final AuthenticationModel _model = AuthenticationModelImpl();

  /// STATES
  bool isLoading = false;
  bool isDisposed = false;

  int chooseGender = 0;
  String name = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String dateOfBirthDay = "";
  String dateOfBirthMonth = "";
  String dateOfBirthYear = "";
  DateTime dateOfBirth = DateTime.now();
  bool isChecked = true;
  File? chooseProfilePicture;
  bool isShowPassword = false;

  /// EVENTS

  onImageChoose(File image) {
    chooseProfilePicture = image;
    notifySafety();
  }

  void onCheckChange() {
    isChecked = !isChecked;
    notifySafety();
  }

  void onChooseGender(int value) {
    chooseGender = value;
    notifySafety();
  }

  void onChangedName(String name) {
    this.name = name;
    notifySafety();
  }

  void onChangedEmail(String email) {
    this.email = email;
    notifySafety();
  }

  void onChangedPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifySafety();
  }

  void onChangeDateOfBirthDay(String day) {
    dateOfBirthDay = day;
    notifySafety();
  }

  void onChangeDateOfBirthMonth(String month) {
    dateOfBirthMonth = month;
    notifySafety();
  }

  void onChangeDateOfBirthYear(String year) {
    dateOfBirthYear = year;
    notifySafety();
  }

  void onChangedDateOfBirth() {
    dateOfBirth = DateTime(int.parse(dateOfBirthYear),
        int.parse(dateOfBirthMonth), int.parse(dateOfBirthDay));
    notifySafety();
  }

  void onChangedPassword(String password) {
    this.password = password;
    notifySafety();
  }

  Future onTapSignUp() {
    showLoading();
    onChangedDateOfBirth();
    return _model
        .registerNewUser(email, name, password, phoneNumber, chooseGender,
            dateOfBirth, chooseProfilePicture)
        .whenComplete(() => hideLoading());
  }

  void toggleShowHidePassword() {
    isShowPassword = !isShowPassword;
    notifySafety();
  }

  void showLoading() {
    isLoading = true;
    notifySafety();
  }

  void hideLoading() {
    isLoading = false;
    notifySafety();
  }

  void notifySafety() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
