import 'package:flutter/material.dart';
import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;
  final List<Photo> photos;

  const AlbumDetailScreen({
    super.key,
    required this.album,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    final albumPhotos = photos.where((p) => p.albumId == album.id).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Album #${album.id}')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title: ${album.title}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text("User ID: ${album.userId}"),
            const Divider(height: 20),
            const Text(
              "Photos:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: albumPhotos.length,
                itemBuilder: (context, index) {
                  final photo = albumPhotos[index];
                  return ListTile(
                    leading: Image.network(
                      photo.thumbnailUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey,
                        );
                      },
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(photo.title),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
