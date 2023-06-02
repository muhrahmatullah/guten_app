import 'package:flutter/material.dart';
import 'package:guten_app/screens/list/book_list_vm.dart';
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
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(vm.data?[idx].title ?? ''),
        );
      },
      itemCount: vm.data?.length ?? 0,
    );
  }
}
