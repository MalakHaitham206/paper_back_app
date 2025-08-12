import 'package:day2_course/model/book_model.dart';
import 'package:flutter/material.dart';

class SavedBooksList extends ChangeNotifier {
  
  final Set<Book> _savedBooks = {
    Book(
      title: "Becoming",
      id: "7",
      description: "The memoir of former First Lady Michelle Obama.",
      author: "Michelle Obama",
      category: "Memoir",
      coverImage: "assets/image/home_images/book7.png",
      rate: 5.0,
    ),
    Book(
      title: "Where the Crawdads Sing",
      id: "8",
      description: "A coming-of-age mystery set in the marshlands.",
      author: "Delia Owens",
      category: "Fiction",
      coverImage: "assets/image/home_images/book8.jpeg",
      rate: 4.5,
    ),
  };
  Set<Book> get savedBooksList => _savedBooks;
  void saveBookInSavedItems(Book book) {
    _savedBooks.add(book);
    notifyListeners();
  }

  void removeBookFromSavedItems(Book book) {
    _savedBooks.remove(book);
    notifyListeners();
  }
  
  
}
