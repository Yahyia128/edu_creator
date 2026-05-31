import 'package:go_router/go_router.dart';

import 'package:edu_creator/features/home/presentation/home_screen.dart';
import 'package:edu_creator/features/editor/presentation/editor_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/editor',
      builder: (context, state) => const EditorScreen(),
    ),
  ],
);