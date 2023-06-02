import 'package:guten_app/model/book_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books.g.dart';

@JsonSerializable()
class Books {
  final int? count;
  final String? next;
  final String? previous;
  final List<BookData>? results;

  factory Books.fromJson(Map<String, dynamic> json) => _$BooksFromJson(json);

  Books(this.count, this.next, this.previous, this.results);
  Map<String, dynamic> toJson() => _$BooksToJson(this);
}
