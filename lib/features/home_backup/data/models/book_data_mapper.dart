import 'package:book_store/core/model/base_data_mapper.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:book_store/features/home_backup/data/models/author_data_mapper.dart';
import 'package:book_store/features/home_backup/data/models/book_response_data.dart';
import 'package:injectable/injectable.dart';
import "dart:math";

@Injectable()
class BookDataMapper extends BaseDataMapper<BookResponseData, Book> {
  BookDataMapper();

  final AuthorDataMapper _authorDataMapper = AuthorDataMapper();

  @override
  Book mapToEntity(BookResponseData? data) {
    final random = Random();
    return Book(
      id: data?.id ?? Book.defaultId,
      name: data?.name ?? Book.defaultName,
      description: data?.description ?? Book.defaultDescription,
      publicationDate: data?.publicationDate ?? Book.defaultPublicationDate,
      price: data?.price ?? Book.defaultPrice,
      createdAt: data?.createdAt ?? Book.defaultCreatedAt,
      updatedAt: data?.updatedAt ?? Book.defaultUpdatedAt,
      author: _authorDataMapper.mapToEntity(data?.author),
      image: images[random.nextInt(images.length)],
    );
  }
}

var images = [
  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/how-to-creative-ideas-book-cover-design-template-52f7ec58f53452b9b46a351cea1bd9a1_screen.jpg",
  "https://s26162.pcdn.co/wp-content/uploads/2019/12/46301955-668x1024.jpg",
  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/how-to-creative-ideas-book-cover-design-template-52f7ec58f53452b9b46a351cea1bd9a1_screen.jpg",
  "https://www.thecreativepenn.com/wp-content/uploads/2018/04/image1.jpeg",
  "https://i.pinimg.com/originals/fc/52/3f/fc523fab7bcc161d8cca966ee974be64.png",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwf6U8c_AwOwZvz9CjfMEzikpESGwcNqSuxQ&usqp=CAU",
  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/teal-and-orange-fantasy-book-cover-design-template-056106feb952bdfb7bfd16b4f9325c11.jpg",
  "https://i.pinimg.com/originals/97/c4/99/97c499de2581f8cca7f415b4d85870a5.jpg",
  "https://i.pinimg.com/736x/4f/59/aa/4f59aaa78f898054f949351515875b3c--book-cover-design-book-design.jpg",
  "https://i.pinimg.com/736x/4f/59/aa/4f59aaa78f898054f949351515875b3c--book-cover-design-book-design.jpg",
  "https://www.edrawsoft.com/templates/images/seaworld-children-book-cover.png",
  "https://www.ingramspark.com/hubfs/Book-Cover-Design-Pillar/32.png",
];
