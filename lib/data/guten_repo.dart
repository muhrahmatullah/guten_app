import 'package:guten_app/data/remote/remote_data_source.dart';
import 'package:guten_app/data/response_wrapper.dart';
import 'package:guten_app/model/book_data.dart';
import 'package:guten_app/model/books.dart';

class GutenRepository {
  final GutenRemoteDataSource dataSource;

  GutenRepository(this.dataSource);

  Future<ResponseWrapper<Books>> fetchBookList(int page) async {
    try {
      final res = await dataSource.fetchBookList(page);
      print('mamank $res');
      return ResponseWrapper.success(data: res);
    } catch (e) {
      return ResponseWrapper.error(error: true);
    }
  }
}
