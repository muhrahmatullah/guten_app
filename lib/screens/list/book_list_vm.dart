import 'package:flutter/material.dart';
import 'package:guten_app/data/guten_repo.dart';
import 'package:guten_app/model/book_data.dart';

class BookListViewModel extends ChangeNotifier {
  BookListViewModel(this.repository);

  final GutenRepository repository;

  List<BookData>? data;
  bool isLoading = true;
  bool isError = false;

  Future<void> fetchBookList(int page) async {
    final resp = await repository.fetchBookList(page);
    if (!resp.error) {
      data = resp.data?.results;
    }
    isError = resp.error;
    isLoading = false;
    notifyListeners();
  }
}
