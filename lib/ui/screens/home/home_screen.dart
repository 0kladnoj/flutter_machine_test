import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../di/di.dart';
import '../../../models/photo_item.dart';
import '../../views/error_view.dart';
import '../../views/loading_view.dart';
import '../details/details_screen.dart';
import 'components/photo_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photos'.toUpperCase(),
          style: const TextStyle(
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => locator<HomeBloc>()..add(const HomeEvent.loadPhotos()),
        child: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return state.when(
                initial: () => const LoadingView(),
                loading: () => const LoadingView(),
                loadedPhotos: (fact) => _buildPhotosList(context, fact),
                error: (error) => ErrorView(error: error),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPhotosList(BuildContext context, List<PhotoItem> photos) {
    return ListView.separated(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photoItem = photos[index];
        return PhotoCard(
          photoItem: photoItem,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailScreen(item: photoItem),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }
}
