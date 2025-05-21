import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../business_logic/album_bloc.dart';
import '../../business_logic/album_event.dart';
import '../../business_logic/album_state.dart';
import '../widgets/album_tile.dart';

// Import AlbumDetailArgs from routes to avoid duplication
import '../../routes/app_router.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                final albumPhotos =
                    state.photos
                        .where((photo) => photo.albumId == album.id)
                        .toList();
                final thumbnail =
                    albumPhotos.isNotEmpty
                        ? albumPhotos.first.thumbnailUrl
                        : null;

                return AlbumTile(
                  albumTitle: album.title,
                  thumbnailUrl: thumbnail,
                  onTap: () {
                    context.go(
                      '/detail',
                      extra: AlbumDetailArgs(album: album, photos: albumPhotos),
                    );
                  },
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumBloc>().add(LoadAlbumsEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
