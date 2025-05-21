import '../data_providers/api_service.dart';
import '../models/album_model.dart';
import '../models/photo_model.dart';

class AlbumRepository {
  final ApiService apiService;

  AlbumRepository({required this.apiService});

  /// Fetch albums from API
  Future<List<Album>> getAlbums() async {
    return await apiService.fetchAlbums();
  }

  /// Fetch photos from API
  Future<List<Photo>> getPhotos() async {
    return await apiService.fetchPhotos();
  }
}
