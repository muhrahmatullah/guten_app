import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guten_app/model/author.dart';
import 'package:guten_app/model/book_data.dart';
import 'package:guten_app/screens/detail/book_detail_vm.dart';
import 'package:guten_app/screens/list/book_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GutenBookDetailScreen extends StatelessWidget {
  static const route = '/detail';
  const GutenBookDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<BookDetailViewModel>(context);
    final bookID = ModalRoute.of(context)?.settings.arguments as String;
    return GutenBookDetailView(vm: vm, bookID: bookID);
  }
}

class GutenBookDetailView extends StatefulWidget {
  const GutenBookDetailView({Key? key, required this.vm, required this.bookID}) : super(key: key);

  final BookDetailViewModel vm;
  final String bookID;

  @override
  State<GutenBookDetailView> createState() => _GutenBookDetailViewState();
}

class _GutenBookDetailViewState extends State<GutenBookDetailView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() async {
      await widget.vm.fetchBookDetail(widget.bookID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _buildBody(widget.vm),
        ),
      ),
    );
  }

  Widget _buildBody(BookDetailViewModel vm) {
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
              await vm.fetchBookDetail(widget.bookID);
            },
          )
        ],
      ));
    }
    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(vm.bookData, context),
            const SizedBox(
              height: 12,
            ),
            Expanded(child: _buildBookBody(vm.bookData, context))
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              vm.getBookUrl().isNotEmpty
                  ? ElevatedButton(
                      onPressed: () async {
                        await launch(vm.getBookUrl());
                      },
                      child: const Text('Read'),
                    )
                  : const SizedBox(),
              const SizedBox(
                width: 8,
              ),
              vm.getAuthorName().isNotEmpty
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, GutenBookListScreen.route, arguments: vm.getAuthorName());
                      },
                      child: const Text('Browse the same author'),
                    )
                  : const SizedBox(),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        )
      ],
    );
  }

  Widget _buildHeader(BookData? bookData, BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 140,
          width: 100,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            child: bookData?.formats?.image?.isNotEmpty == true
                ? CachedNetworkImage(
                    imageUrl: bookData?.formats?.image ?? '',
                    fit: BoxFit.cover,
                  )
                : const Center(child: Text('No Image data')),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookData?.title ?? '',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            Text('Author(s): ${_getAuthors(bookData)}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black)),
            const SizedBox(
              height: 8,
            ),
            Text('Available in: ${_getLang(bookData)}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black)),
            const SizedBox(
              height: 8,
            ),
            Text('Download count: ${bookData?.downloadCount?.toString()}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black))
          ],
        ))
      ],
    );
  }

  String _getAuthors(BookData? bookData) {
    String authors = '';
    if (bookData?.authors?.isNotEmpty == true) {
      for (Author author in bookData?.authors ?? []) {
        authors += _formatAuthorName(author.name);
      }
    }
    return authors;
  }

  String _formatAuthorName(String name) {
    String result = '';
    List<String> _name = name.split(',');
    if (_name.length > 1) {
      result = '${_name[1].trim()} ${_name[0]}';
    }
    return result;
  }

  String _getLang(BookData? bookData) {
    String lang = '';
    if (bookData?.languages?.isNotEmpty == true) {
      if (bookData?.languages?.length == 1) {
        lang = bookData?.languages?[0] ?? '';
      } else {
        for (String _lang in bookData?.languages ?? []) {
          lang += '$_lang, ';
        }
      }
    }
    return lang;
  }

  Widget _buildBookBody(BookData? bookData, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
        flexibleSpace: Column(
          children: [
            TabBar(
              indicatorWeight: 1.0,
              labelColor: Colors.black,
              indicatorColor: Colors.blueAccent,
              tabs: [
                Tab(
                  child: Text(
                    'Subjects',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Book shelves',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                )
              ],
              controller: _tabController,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: TabBarView(
          children: [
            GutenChipView(texts: bookData?.subjects ?? []),
            GutenChipView(texts: bookData?.bookshelves ?? []),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

class GutenChipView extends StatelessWidget {
  const GutenChipView({Key? key, required this.texts}) : super(key: key);

  final List<String> texts;
  @override
  Widget build(BuildContext context) {
    final widgets = texts
        .map((e) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ),
            ))
        .toList();
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Wrap(
          children: widgets,
        ),
      ),
    );
  }
}
