import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? password;
  String? about;
  String? workStats;
  String? iconFb;
  String? iconIg;
  String? iconTw;
  String? iconGh;
  String? name;
  int? age;
  String? birthdate;
  String? sex;
  String? address;
  int? contactNo;
  String? religion;
  String? maritalStats;

  UserModel({
    required this.email,
    required this.password,
    required this.about,
    required this.workStats,
    required this.iconFb,
    required this.iconIg,
    required this.iconTw,
    required this.iconGh,
    required this.name,
    required this.age,
    required this.birthdate,
    required this.sex,
    required this.address,
    required this.contactNo,
    required this.religion,
    required this.maritalStats
  });

  Map<String, dynamic> toJson() => {
    'email' : email,
    'password' : password,
    'about' : about,
    'workStats' : workStats,
    'iconFb' : iconFb,
    'iconIg' : iconIg,
    'iconTw' : iconTw,
    'iconGh' : iconGh,
    'name' : name,
    'age' : age,
    'birthdate' : birthdate,
    'sex' : sex,
    'address' : address,
    'contactNo' : contactNo,
    'religion' : religion,
    'maritalStats' : maritalStats,
  };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'],
      password: json['password'],
      about: json['about'],
      workStats: json['workStats'],
      iconFb: json['iconFb'],
      iconIg: json['iconIg'],
      iconTw: json['iconTw'],
      iconGh: json['iconGh'],
      name: json['name'],
      age: json['age'],
      birthdate: json['birthdate'],
      sex: json['sex'],
      address: json['address'],
      contactNo: json['contactNo'],
      religion: json['religion'],
      maritalStats: json['maritalStats']
  );

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
        email: data['email'],
        password: data['password'],
        about: data['about'],
        workStats: data['workStats'],
        iconFb: data['iconFb'],
        iconIg: data['iconIg'],
        iconTw: data['iconTw'],
        iconGh: data['iconGh'],
        name: data['name'],
        age: data['age'],
        birthdate: data['birthdate'],
        sex: data['sex'],
        address: data['address'],
        contactNo: data['contactNo'],
        religion: data['religion'],
        maritalStats: data['maritalStats']
    );

  }
}