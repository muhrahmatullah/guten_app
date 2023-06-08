import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guten_app/model/book_data.dart';
import 'package:guten_app/util/util.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({Key? key, required this.onTap, required this.bookData, required this.idx}) : super(key: key);

  final Function(String) onTap;
  final BookData? bookData;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(bookData?.id.toString() ?? '');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(child: _buildBackground(idx)),
                  ),
                  Align(
                    child: _buildBookUI(),
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              bookData?.title ?? '',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            ),
            Text(
              bookData?.authors?.isNotEmpty == true ? bookData?.authors?.first.name ?? '' : 'Unknown',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBookUI() {
    return Container(
      height: 140,
      width: 100,
      decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 18.0, offset: Offset(0.0, 0.75))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: bookData?.formats?.image?.isNotEmpty == true
            ? CachedNetworkImage(
                imageUrl: bookData?.formats?.image ?? '',
                fit: BoxFit.cover,
              )
            : const Center(child: Text('No Image data')),
      ),
    );
  }

  Widget _buildBackground(int idx) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 8.0, offset: Offset(0.0, 0.0))],
          color: GutenUiMixin.getRandomColor(idx),
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
