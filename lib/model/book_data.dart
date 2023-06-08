import 'package:json_annotation/json_annotation.dart';

import 'author.dart';

part 'book_data.g.dart';

@JsonSerializable()
class BookData {
  final int? id;
  final String? title;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final List<Author>? authors;
  final List<Author>? translators;
  final bool? copyright;
  final String? mediaType;
  final Format? formats;
  @JsonKey(name: 'download_count')
  final int? downloadCount;

  factory BookData.fromJson(Map<String, dynamic> json) => _$BookDataFromJson(json);

  BookData(this.id, this.title, this.subjects, this.bookshelves, this.languages, this.copyright, this.mediaType, this.downloadCount,
      this.authors, this.formats, this.translators);

  Map<String, dynamic> toJson() => _$BookDataToJson(this);
}

@JsonSerializable()
class Format {
  @JsonKey(name: 'image/jpeg')
  final String? image;

  @JsonKey(name: 'text/html')
  final String? textHtml;

  @JsonKey(name: 'text/plain')
  final String? textPlain;

  Format(this.image, this.textHtml, this.textPlain);
  factory Format.fromJson(Map<String, dynamic> json) => _$FormatFromJson(json);
  Map<String, dynamic> toJson() => _$FormatToJson(this);
}
