import 'dart:convert';

import 'package:drive_doctor/core/services/StringManager.dart';
import 'package:drive_doctor/core/services/shared_helper.dart';

class UserModel {
  String? uid;
  String? photoUrl;

  String? userEmail;
  String? userPassword;
  String? userFullName;
  String? fireBaseToken;

  UserModel({
    this.uid,
    this.photoUrl,

    this.userFullName,
    this.fireBaseToken,
    this.userEmail,
    this.userPassword,

  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'photoUrl': photoUrl,

      'userFullName': userFullName,
      'fireBaseToken': fireBaseToken,
      'userEmail':userEmail,
      'userPassword':userPassword,

    };
  }
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      photoUrl: map['photoUrl'],
      userFullName: map['userFullName'],
      fireBaseToken: map['fireBaseToken'],
      userEmail: map['userEmail'],
      userPassword: map['userPassword'],
    );
  }

  static Future<void> saveUserModel({required UserModel userModel}) async {
    final userMap = userModel.toMap();
    final userJson = json.encode(userMap);

    await CashHelper.setData(key: StringManager.userModel,value:  userJson);
  }

  static UserModel? getUserModel() {
    final userJson = CashHelper.getData(key:  StringManager.userModel);
    if (userJson != null) {
      final userMap = json.decode(userJson);
      return UserModel.fromMap(userMap);
    }
    return null;
  }
}