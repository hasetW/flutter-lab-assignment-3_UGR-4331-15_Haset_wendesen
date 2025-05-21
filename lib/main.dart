import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/album_bloc.dart';
import 'business_logic/album_event.dart';
import 'business_logic/album_state.dart';

import 'data/data_providers/api_service.dart';
import 'data/repositories/album_repository.dart';

import 'routes/app_router.dart'; // Import here, no other AlbumDetailArgs anywhere else

void main() {
  final apiService = ApiService();
  final repository = AlbumRepository(apiService: apiService);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AlbumRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumBloc(repository: repository)..add(LoadAlbumsEvent()),
      child: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoaded) {
            final router = AppRouter().router; // Use the router normally
            return MaterialApp.router(
              title: 'Album App',
              routerConfig: router,
              debugShowCheckedModeBanner: false,
            );
          } else if (state is AlbumError) {
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(title: const Text('Error')),
                body: Center(
                  child: Text(
                    'Failed to load albums:\n${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              ),
            );
          } else {
            return const MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())),
            );
          }
        },
      ),
    );
  }
}
