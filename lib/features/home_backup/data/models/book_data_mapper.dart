import 'package:book_store/core/model/base_data_mapper.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:book_store/features/home_backup/data/models/author_data_mapper.dart';
import 'package:book_store/features/home_backup/data/models/book_response_data.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class BookDataMapper extends BaseDataMapper<BookResponseData, Book> {
  BookDataMapper();

  final AuthorDataMapper _authorDataMapper = AuthorDataMapper();

  @override
  Book mapToEntity(BookResponseData? data) {
    return Book(
      id: data?.id ?? Book.defaultId,
      name: data?.name ?? Book.defaultName,
      description: data?.description ?? Book.defaultDescription,
      publicationDate: data?.publicationDate ?? Book.defaultPublicationDate,
      price: data?.price ?? Book.defaultPrice,
      createdAt: data?.createdAt ?? Book.defaultCreatedAt,
      updatedAt: data?.updatedAt ?? Book.defaultUpdatedAt,
      author: _authorDataMapper.mapToEntity(data?.author),
    );
  }
}
