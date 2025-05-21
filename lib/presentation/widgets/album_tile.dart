import 'package:flutter/material.dart';

class AlbumTile extends StatelessWidget {
  final String albumTitle;
  final String? thumbnailUrl;
  final VoidCallback onTap;

  const AlbumTile({
    super.key,
    required this.albumTitle,
    required this.thumbnailUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          thumbnailUrl != null
              ? SizedBox(
                width: 50,
                height: 50,
                child: Image.network(
                  thumbnailUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image);
                  },
                ),
              )
              : const Icon(Icons.image_not_supported),
      title: Text(albumTitle),
      onTap: onTap,
    );
  }
}
