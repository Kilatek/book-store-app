// To parse this JSON data, do
//
//     final getAuthorsModel = getAuthorsModelFromJson(jsonString);

import 'dart:convert';

List<GetAuthorsModel> getAuthorsModelFromJson(String str) =>
    List<GetAuthorsModel>.from(
        json.decode(str).map((x) => GetAuthorsModel.fromJson(x)));

String getAuthorsModelToJson(List<GetAuthorsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAuthorsModel {
  String? id;
  String? firstName;
  String? lastName;
  String? birthDate;
  String? nationality;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetAuthorsModel({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.nationality,
    this.createdAt,
    this.updatedAt,
  });

  factory GetAuthorsModel.fromJson(Map<String, dynamic> json) =>
      GetAuthorsModel(
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDate: json["birthDate"] == null ? null : json["birthDate"],
        nationality: json["nationality"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "birthDate": birthDate,
        "nationality": nationality,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
