import 'package:book_store/core/model/base_data_mapper.dart';
import 'package:book_store/features/auth/data/models/auth_response_data.dart';
import 'package:book_store/features/auth/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UserDataMapper extends BaseDataMapper<AuthResponseData, User> {
  UserDataMapper();

  @override
  User mapToEntity(AuthResponseData? data) {
    return const User(
      id: User.defaultId,
      username: User.defaultUsername,
      firstName: User.defaultFirstName,
      lastName: User.defaultLastName,
    );
  }
}
