import 'package:dio/dio.dart';
import 'package:guten_app/model/book_data.dart';
import 'package:guten_app/model/books.dart';

class AppClientService {
  AppClientService(this.dio, this.baseUrl);

  final Dio dio;
  final String baseUrl;

  Future<Books> fetchBookList(int page) async {
    Response response;
    try {
      response = await dio.get(
        '$baseUrl/books?page=$page',
      );
      final res = Books.fromJson(response.data);

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
