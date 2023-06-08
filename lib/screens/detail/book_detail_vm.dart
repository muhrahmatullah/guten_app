import 'package:flutter/material.dart';
import 'package:guten_app/data/guten_repo.dart';
import 'package:guten_app/model/book_data.dart';

class BookDetailViewModel extends ChangeNotifier {
  final GutenRepository repository;

  bool isError = false;

  bool isLoading = true;

  BookData? bookData;

  BookDetailViewModel(this.repository);

  Future<void> fetchBookDetail(String id) async {
    if (isError) {
      isLoading = true;
      notifyListeners();
    }
    final resp = await repository.fetchBookDetail(id);
    if (!resp.error) {
      bookData = resp.data;
    }
    isError = resp.error;
    isLoading = false;
    notifyListeners();
  }

  String getBookUrl() {
    if (bookData?.formats?.textHtml?.isNotEmpty == true) {
      return bookData?.formats?.textHtml ?? '';
    }
    if (bookData?.formats?.textPlain?.isNotEmpty == true) {
      return bookData?.formats?.textPlain ?? '';
    }

    return '';
  }

  String getAuthorName() {
    if (bookData?.authors?.isNotEmpty == true) {
      String _name = bookData?.authors?.first.name ?? '';
      String name = _name.split(',').last.trim();
      return name;
    }
    return '';
  }
}
