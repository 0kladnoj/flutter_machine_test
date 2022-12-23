import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/photo_item.dart';
import '../../../../utils/app_utils.dart';

class PhotoCard extends StatelessWidget {
  final PhotoItem photoItem;
  final VoidCallback? onTap;

  const PhotoCard({
    super.key,
    required this.photoItem,
    this.onTap,
  });

  int get _id => photoItem.id;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(AppUtils.cardKey(_id)),
      elevation: 4,
      child: ListTile(
        onTap: onTap,
        leading: Hero(tag: AppUtils.photoTag(_id), child: _buildImage()),
        title: Text(photoItem.title),
        dense: true,
        visualDensity: const VisualDensity(vertical: 4),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: photoItem.thumbnailUrl,
      placeholder: (_, __) => const CircularProgressIndicator(),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
