import 'package:flutter/material.dart';

import '../../editor/presentation/editor_screen.dart';
import 'saved_lessons_screen.dart';

class HomeScreen
    extends StatelessWidget {

  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Edu Creator',
        ),

      ),

      body: Padding(

        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Column(

          children: [

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          const EditorScreen(),

                    ),

                  );

                },

                child: const Text(
                  'Create Lesson',
                ),

              ),

            ),

            const SizedBox(
              height: 16,
            ),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          const SavedLessonsScreen(),

                    ),

                  );

                },

                child: const Text(
                  'Saved Lessons',
                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}