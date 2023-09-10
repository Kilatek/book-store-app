// To parse this JSON data, do
//
//     final authorCreatedModel = authorCreatedModelFromJson(jsonString);

import 'dart:convert';

import 'package:book_store/features/author/domain/entities/author.dart';

AuthorCreatedModel authorCreatedModelFromJson(String str) =>
    AuthorCreatedModel.fromJson(json.decode(str));

String authorCreatedModelToJson(AuthorCreatedModel data) =>
    json.encode(data.toJson());

class AuthorCreatedModel extends Author {
  String firstName;
  String lastName;
  String birthDate;
  String nationality;

  AuthorCreatedModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.nationality,
  }) : super('', '', '', '');

  factory AuthorCreatedModel.fromJson(Map<String, dynamic> json) =>
      AuthorCreatedModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDate: json["birthDate"],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "birthDate": birthDate,
        "nationality": nationality,
      };
}
