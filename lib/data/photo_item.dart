import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_item.g.dart';

List<PhotoItem> photosFromResponse(List results) {
  return results.map((e) => PhotoItem.fromJson(e)).toList();
}

@JsonSerializable()
class PhotoItem extends Equatable {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoItem({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  @override
  List<Object> get props => [albumId, id, title, url, thumbnailUrl];

  factory PhotoItem.fromJson(Map<String, dynamic> json) =>
      _$PhotoItemFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoItemToJson(this);
}
