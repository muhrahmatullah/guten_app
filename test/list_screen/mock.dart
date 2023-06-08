import 'package:guten_app/data/guten_repo.dart';
import 'package:guten_app/model/author.dart';
import 'package:guten_app/model/book_data.dart';
import 'package:guten_app/screens/detail/book_detail_vm.dart';
import 'package:guten_app/screens/list/book_list_vm.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements GutenRepository {}

class MockBookListViewModel extends Mock implements BookListViewModel {
  @override
  bool get isLoading => true;
  @override
  List<BookData>? get data => [
        BookData(1, 'title', [], [], [], false, '', 1, [Author('author', null, null)], null, null)
      ];
}

class MockBookDetailViewModel extends Mock implements BookDetailViewModel {}
