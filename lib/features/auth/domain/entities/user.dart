import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    @Default(User.defaultId) int id,
    @Default(User.defaultUsername) String username,
    @Default(User.defaultAccessToken) String accessToken,
    @Default(User.defaultFirstName) String firstName,
    @Default(User.defaultLastName) String lastName,
  }) = _User;

  static const defaultId = 0;
  static const defaultUsername = '';
  static const defaultAccessToken = '';
  static const defaultFirstName = '';
  static const defaultLastName = '';
}
