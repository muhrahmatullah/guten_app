import 'package:flutter/material.dart';
import 'package:guten_app/screens/list/book_list_vm.dart';
import 'package:guten_app/screens/widget/book_widget.dart';
import 'package:guten_app/screens/widget/search_sheet.dart';
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
  ScrollController getScrollController(BookListViewModel vm) {
    final _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (vm.isLoadMore || vm.isLoadMore || !vm.hasNext) {
          return;
        }
        await vm.loadMore();
      }
    });
    return _scrollController;
  }

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
        appBar: AppBar(
          title: const Text(
            'Guten App',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: SearchBottomSheet(onTap: (author, title) async {
                          widget.vm.isSearch = true;
                          if (author.isNotEmpty || title.isNotEmpty) await widget.vm.fetchBookList(1, author: author, title: title);
                        }),
                      );
                    });
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: Container(
          child: _buildBody(widget.vm),
        ));
  }

  Widget _buildBody(BookListViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.isError) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Something went wrong'),
          TextButton(
            child: const Text('Try Again'),
            onPressed: () async {
              await vm.fetchBookList(1);
            },
          )
        ],
      ));
    }
    return SingleChildScrollView(
      controller: getScrollController(vm),
      child: Column(
        children: [
          vm.author?.isNotEmpty == true || vm.title?.isNotEmpty == true
              ? const SizedBox(
                  height: 18,
                )
              : const SizedBox(height: 6),
          vm.author?.isNotEmpty == true || vm.title?.isNotEmpty == true
              ? _searchResult(
                  vm.author,
                  vm.title,
                )
              : const SizedBox(),
          vm.author?.isNotEmpty == true || vm.title?.isNotEmpty == true
              ? const SizedBox(
                  height: 4,
                )
              : const SizedBox(),
          GridView.builder(
            controller: getScrollController(vm),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 230),
            itemCount: vm.data?.length ?? 0,
            itemBuilder: (_, index) {
              return BookWidget(
                onTap: (id) {},
                bookData: vm.data?[index],
                idx: index,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _searchResult(String? author, String? title) {
    return Column(
      children: [
        Text('Showing books of ${getAuthorTitle(author, title)}'),
        TextButton(
            onPressed: () {
              widget.vm.fetchBookList(1);
            },
            child: const Text('Clear Search')),
      ],
    );
  }

  String getAuthorTitle(String? author, String? title) {
    String result = '';
    if (author?.isNotEmpty == true) {
      result += 'Author: $author';
    }
    if (title?.isNotEmpty == true) {
      result += ' - Title: $title';
    }
    return result;
  }
}
