
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/data/vos/user_vo.dart';

class ProfileBloc extends ChangeNotifier {
  /// STATES
  bool isLoading = false;
  bool isDisposed = false;

  String userName = "";
  String email = "";
  String phoneNumber = "";
  String dateOfBirthDay = "";
  String dateOfBirthMonth = "";
  String dateOfBirthYear = "";
  DateTime dateOfBirth = DateTime.now();
  int chooseGender = 0;
  String? profilePicture;
  UserVO? loggedInUser;
  File? chooseProfilePicture;

  final AuthenticationModel _model = AuthenticationModelImpl();

  ProfileBloc() {
    _model.getCurrentUserInfo().listen((user) {
      userName = user.name ?? "";
      email = user.email ?? "";
      phoneNumber = user.phoneNumber ?? "";
      dateOfBirth = user.dateOfBirth ?? DateTime.now();
      chooseGender = user.gender ?? -1;
      profilePicture = user.profilePicture ?? "";
      loggedInUser = user;
      notifySafety();
    });
  }

  void onChooseGender(int value) {
    chooseGender = value;
    notifySafety();
  }

  void onChangedName(String name) {
    userName = name;
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
    dateOfBirth = DateTime(int.parse(dateOfBirthYear),int.parse(dateOfBirthMonth),int.parse(dateOfBirthDay));
    notifySafety();
  }

  // Future onTapSignUp() {
  //   showLoading();
  //   onChangedDateOfBirth();
  //   UserVO userVO = UserVO(
  //       id: "",
  //       name: userName,
  //       email: email,
  //       phoneNumber: phoneNumber,
  //       dateOfBirth: dateOfBirth,
  //       gender: chooseGender
  //   );
  //   return _model.registerNewUser(userVO).whenComplete(() => hideLoading());
  // }

  onImageChoose(File image) {
    chooseProfilePicture = image;
    notifySafety();
    if(chooseProfilePicture != null) {
      _model.updateUserInfo(loggedInUser?.id ?? "", email, userName, loggedInUser?.password ?? "", phoneNumber, chooseGender, dateOfBirth, chooseProfilePicture, loggedInUser?.deviceToken ?? "").then((_) {
        _model.getCurrentUserInfo().listen((user) {
          userName = user.name ?? "";
          email = user.email ?? "";
          phoneNumber = user.phoneNumber ?? "";
          dateOfBirth = user.dateOfBirth ?? DateTime.now();
          chooseGender = user.gender ?? -1;
          profilePicture = user.profilePicture ?? "";
          loggedInUser = user;
          notifySafety();
        });
      });
    }
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