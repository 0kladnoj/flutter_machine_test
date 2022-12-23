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
            SliverAppBar(
              title: const Text(''),
              backgroundColor: Colors.white,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: AppUtils.photoTag(item.id),
                  child: CachedNetworkImage(
                    imageUrl: item.url,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Text(
                  'Id: ${item.id}',
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  item.title,
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Text(
                  'album #: ${item.albumId}',
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
