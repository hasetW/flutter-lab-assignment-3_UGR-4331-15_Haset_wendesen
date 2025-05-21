import 'package:go_router/go_router.dart';
import '../data/models/album_model.dart';
import '../data/models/photo_model.dart';
import '../presentation/screens/album_list_screen.dart';
import '../presentation/screens/album_detail_screen.dart';

class AlbumDetailArgs {
  final Album album;
  final List<Photo> photos;

  AlbumDetailArgs({required this.album, required this.photos});
}

class AppRouter {
  late final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const AlbumListScreen()),
      GoRoute(
        path: '/detail',
        builder: (context, state) {
          final args = state.extra as AlbumDetailArgs;
          return AlbumDetailScreen(album: args.album, photos: args.photos);
        },
      ),
    ],
  );
}
