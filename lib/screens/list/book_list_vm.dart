import 'package:flutter/material.dart';
import 'package:guten_app/data/guten_repo.dart';
import 'package:guten_app/model/book_data.dart';

class BookListViewModel extends ChangeNotifier {
  BookListViewModel(this.repository);

  final GutenRepository repository;

  List<BookData>? data;
  bool isLoading = true;
  bool isError = false;
  bool isLoadMore = false;
  bool hasNext = false;
  bool isSearch = false;
  int page = 1;
  String? title = '';
  String? author = '';

  Future<void> fetchBookList(
    int page, {
    String? title,
    String? author,
  }) async {
    if (isError || isSearch) {
      isLoading = true;
      notifyListeners();
    }
    final resp = await repository.fetchBookList(page, author: author, title: title);
    this.author = author;
    this.title = title;
    if (!resp.error) {
      data = resp.data?.results;
      this.page = page + 1;
      hasNext = resp.data?.next?.isNotEmpty == true;
    }
    isError = resp.error;
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    isLoadMore = true;
    notifyListeners();
    final resp = await repository.fetchBookList(page, author: author, title: title);
    if (!resp.error) {
      final List<BookData>? additionalData = data;
      additionalData?.addAll(resp.data?.results ?? []);
      data = additionalData;
      page = page + 1;
      hasNext = resp.data?.next?.isNotEmpty == true;
    }
    isLoadMore = false;
    notifyListeners();
  }
}
