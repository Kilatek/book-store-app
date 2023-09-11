import 'package:book_store/features/author/presentation/widgets/auhor_item.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorPage extends StatefulWidget {
  List<Author> authors = [];
  AuthorPage(this.authors);
  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  List<Author> authors = [
    Author(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      birthDate: '1990-05-15',
      nationality: 'American',
      createdAt: '2022-01-10',
      updatedAt: '2022-05-20',
      image: 'john_doe.jpg',
    ),
    Author(
      id: '2',
      firstName: 'Jane',
      lastName: 'Smith',
      birthDate: '1985-09-20',
      nationality: 'British',
      createdAt: '2021-12-05',
      updatedAt: '2022-04-15',
      image: 'jane_smith.jpg',
    ),
    // Add more author objects here...
    Author(
      id: '30',
      firstName: 'Michael',
      lastName: 'Johnson',
      birthDate: '1978-03-08',
      nationality: 'Canadian',
      createdAt: '2022-03-18',
      updatedAt: '2022-06-25',
      image: 'michael_johnson.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            authors.length,
            (index) => AuthorItem(
              author: authors[index],
            ),
          ),
        ),
      ),
    );

    //   ListView.builder(
    //     itemCount: authors.length,
    //     itemBuilder: (context, index) {
    //       final author = authors[index];
    //       final firstChar = author.firstName[0];
    //       return InkWell(
    //         onTap: () {
    //           _navigateToAuthorDetail(author); // Navigate to detail screen
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Card(
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //             elevation: 5,
    //             child: ListTile(
    //               leading: CircleAvatar(
    //                 child: Text(firstChar,
    //                     style: TextStyle(
    //                         fontSize: 18, fontWeight: FontWeight.bold)),
    //               ),
    //               title: Text('${author.firstName} ${author.lastName}'),
    //               subtitle: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text('BirthDate: ${author.birthDate}'),
    //                   Text('Nationality: ${author.nationality}'),
    //                 ],
    //               ),
    //               trailing: PopupMenuButton<String>(
    //                 itemBuilder: (context) {
    //                   return <PopupMenuEntry<String>>[
    //                     PopupMenuItem<String>(
    //                       value: 'edit',
    //                       child: Text('Edit'),
    //                     ),
    //                     PopupMenuItem<String>(
    //                       value: 'remove',
    //                       child: Text('Remove'),
    //                     ),
    //                   ];
    //                 },
    //                 onSelected: (String choice) {
    //                   if (choice == 'edit') {
    //                     // Add logic for editing the author here
    //                     // You can navigate to an edit screen or show a dialog, for example
    //                   } else if (choice == 'remove') {
    //                     // Add logic for removing the author here
    //                     setState(() {
    //                       authors.removeAt(index);
    //                     });
    //                   }
    //                 },
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       // Add logic to update the list of authors here (e.g., using setState)
    //       setState(() {
    //         authors.add(
    //           Author(
    //               firstName: 'New',
    //               lastName: 'Author',
    //               birthDate: '01/01/2000',
    //               nationality: 'Unknown'),
    //         );
    //       });
    //     },
    //     child: Icon(Icons.add),
    //   ),
    // );
  }
}
