import 'package:dio/dio.dart';
import 'package:guten_app/model/book_data.dart';
import 'package:guten_app/model/books.dart';

class AppClientService {
  AppClientService(this.dio, this.baseUrl);

  final Dio dio;
  final String baseUrl;

  Future<Books> fetchBookList(int page, {String? author, String? title}) async {
    Response response;
    try {
      Map<String, dynamic> query = {};
      if (author?.isNotEmpty == true) {
        if (title?.isNotEmpty == true) {
          query['search'] = '$author $title';
        }
        query['search'] = '$author';
      } else if (title?.isNotEmpty == true) {
        query['search'] = '$title';
      }
      response = await dio.get('$baseUrl/books?page=$page', queryParameters: query);
      final res = Books.fromJson(response.data);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<BookData> fetchBookDetail(String id) async {
    Response response;
    try {
      response = await dio.get('$baseUrl/books/$id');
      final res = BookData.fromJson(response.data);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
