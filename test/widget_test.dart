import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:album/main.dart';

import 'package:album/data/data_providers/api_service.dart';
import 'package:album/data/repositories/album_repository.dart';

void main() {
  testWidgets('Basic widget test with repository', (WidgetTester tester) async {
    final apiService = ApiService();
    final repository = AlbumRepository(apiService: apiService);

    await tester.pumpWidget(MyApp(repository: repository));

    // Example: Wait for widgets to build and show CircularProgressIndicator initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // You can add more tests as you develop your app...
  });
}
