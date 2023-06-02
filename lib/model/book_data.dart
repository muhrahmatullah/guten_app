import 'package:json_annotation/json_annotation.dart';

part 'book_data.g.dart';

@JsonSerializable()
class BookData {
  final int? id;
  final String? title;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  @JsonKey(name: 'download_count')
  final int? downloadCount;

  factory BookData.fromJson(Map<String, dynamic> json) =>
      _$BookDataFromJson(json);

  BookData(this.id, this.title, this.subjects, this.bookshelves, this.languages,
      this.copyright, this.mediaType, this.downloadCount);

  Map<String, dynamic> toJson() => _$BookDataToJson(this);
}
