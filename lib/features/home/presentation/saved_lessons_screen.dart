import 'package:flutter/material.dart';

class SavedLessonsScreen
    extends StatelessWidget {

  const SavedLessonsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Saved Lessons',
        ),

      ),

      body: const Center(

        child: Text(
          'Storage system coming soon',
        ),

      ),

    );

  }

}