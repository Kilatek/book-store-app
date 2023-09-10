import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String firstName;
  final String lastName;
  final String birthDate;
  final String Nationality;

  Author(
    this.firstName,
    this.lastName,
    this.birthDate,
    this.Nationality,
  );

  @override
  List<Object?> get props => [firstName, lastName, birthDate, Nationality];
}
