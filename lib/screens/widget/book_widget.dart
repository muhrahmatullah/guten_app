import 'package:flutter/material.dart';
import 'package:guten_app/model/book_data.dart';
import 'package:guten_app/util/util.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({Key? key, required this.onTap, required this.bookData})
      : super(key: key);

  final Function(String) onTap;
  final BookData? bookData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(child: _buildBackground()),
                  ),
                  Align(
                    child: _buildBookUI(),
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            bookData?.title ?? '',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
          Text(
            bookData?.authors?.first.name ?? '',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget _buildBookUI() {
    return Container(
      height: 140,
      width: 100,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black54, blurRadius: 18.0, offset: Offset(0.0, 0.75))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          bookData?.formats?.image ??
              'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/art-book-cover-design-template-34323b0f0734dccded21e0e3bebf004c_screen.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 8.0,
                offset: Offset(0.0, 0.0))
          ],
          color: GutenUiMixin.getRandomColor(),
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
