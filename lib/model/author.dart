import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  final String name;
  @JsonKey(name: 'birth_year')
  final int? birthYear;
  @JsonKey(name: 'death_year')
  final int? deathYear;

  Author(this.name, this.birthYear, this.deathYear);

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
