import 'package:flutter/material.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({Key? key, required this.onTap}) : super(key: key);

  final Function(String, String) onTap;

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  String author = '';
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          TextField(
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Author'),
            onChanged: (value) {
              setState(() {
                author = value;
              });
            },
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Title'),
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () {
                widget.onTap(author, title);
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Search',
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
