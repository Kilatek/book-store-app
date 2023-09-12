import 'dart:math';

import 'package:book_store/core/model/base_data_mapper.dart';
import 'package:book_store/features/home/domain/entities/author.dart';
import 'package:book_store/features/home/data/models/author_response_data.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthorDataMapper extends BaseDataMapper<AuthorResponseData, Author> {
  AuthorDataMapper();

  @override
  Author mapToEntity(AuthorResponseData? data) {
    final random = Random();
    return Author(
      id: data?.id ?? Author.defaultId,
      firstName: data?.firstName ?? Author.defaultFirstName,
      lastName: data?.lastName ?? Author.defaultLastName,
      birthDate: data?.birthDate ?? Author.defaultBirthDate,
      nationality: data?.nationality ?? Author.defaultNationality,
      createdAt: data?.createdAt ?? Author.defaultCreatedAt,
      updatedAt: data?.updatedAt ?? Author.defaultUpdatedAt,
      image: "https://i.pravatar.cc/300?img=${random.nextInt(10)}",
    );
  }
}
