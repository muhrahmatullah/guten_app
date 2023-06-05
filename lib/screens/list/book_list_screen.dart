import 'package:flutter/material.dart';
import 'package:guten_app/screens/list/book_list_vm.dart';
import 'package:guten_app/screens/widget/book_widget.dart';
import 'package:provider/provider.dart';

class GutenBookListScreen extends StatelessWidget {
  static const route = '/home';
  const GutenBookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookListVM = Provider.of<BookListViewModel>(context);
    return GutenBookListView(vm: bookListVM);
  }
}

class GutenBookListView extends StatefulWidget {
  const GutenBookListView({Key? key, required this.vm}) : super(key: key);

  final BookListViewModel vm;

  @override
  State<GutenBookListView> createState() => _GutenBookListViewState();
}

class _GutenBookListViewState extends State<GutenBookListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await widget.vm.fetchBookList(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: _buildBody(widget.vm),
    ));
  }

  Widget _buildBody(BookListViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.isError) {
      return const Center(child: Text('Something went wrong'));
    }
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 230),
      itemCount: vm.data?.length ?? 0,
      itemBuilder: (_, index) {
        return BookWidget(onTap: (id) {}, bookData: vm.data?[index]);
      },
    );
  }
}
