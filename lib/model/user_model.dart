import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? password;
  String? about;
  String? name;
  int? age;
  String? birthdate;
  String? sex;
  String? address;

  UserModel({
    required this.email,
    required this.password,
    required this.about,
    required this.name,
    required this.age,
    required this.birthdate,
    required this.sex,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'email' : email,
    'password' : password,
    'about' : about,
    'name' : name,
    'age' : age,
    'birthdate' : birthdate,
    'sex' : sex,
    'address' : address,
  };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'],
      password: json['password'],
      about: json['about'],
      name: json['name'],
      age: json['age'],
      birthdate: json['birthdate'],
      sex: json['sex'],
      address: json['address'],
  );

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
        email: data['email'],
        password: data['password'],
        about: data['about'],
        name: data['name'],
        age: data['age'],
        birthdate: data['birthdate'],
        sex: data['sex'],
        address: data['address'],
    );

  }
}