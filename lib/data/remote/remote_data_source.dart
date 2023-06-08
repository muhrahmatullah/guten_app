import 'package:guten_app/data/remote/http_client.dart';
import 'package:guten_app/data/response_wrapper.dart';
import 'package:guten_app/model/book_data.dart';
import 'package:guten_app/model/books.dart';

class GutenRemoteDataSource {
  GutenRemoteDataSource(this.clientService);

  final AppClientService clientService;

  Future<Books?> fetchBookList(int page, {String? author, String? title}) async {
    try {
      final res = await clientService.fetchBookList(page, author: author, title: title);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
