import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/photo_item.dart';
import '../../../utils/app_utils.dart';

class DetailScreen extends StatelessWidget {
  final PhotoItem item;

  const DetailScreen({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            _buildIcon(),
            _buildId(),
            _buildItemTitle(),
            _buildAlbum(),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildIcon() {
    return SliverAppBar(
      title: const Text(''),
      backgroundColor: Colors.white,
      expandedHeight: 360,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: AppUtils.photoTag(item.id),
          child: CachedNetworkImage(
            imageUrl: item.url,
            placeholder: (_, __) => const CircularProgressIndicator(),
            errorWidget: (_, __, ___) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildId() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Text(
          AppUtils.photoId(item.id),
          maxLines: 3,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildItemTitle() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Text(
          item.title,
          maxLines: 3,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAlbum() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
        ),
        child: Text(
          AppUtils.photoAlbum(item.albumId),
          maxLines: 3,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
