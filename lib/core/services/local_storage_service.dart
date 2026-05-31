import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorageService {

  static Future<String> get _localPath async {

    final directory =
        await getApplicationDocumentsDirectory();

    return directory.path;

  }

  static Future<File> _localFile(
    String fileName,
  ) async {

    final path =
        await _localPath;

    return File(
      '$path/$fileName.json',
    );

  }

  // SAVE LESSON
  static Future<void> saveLesson({

    required String fileName,

    required List<Map<String, dynamic>> blocks,

  }) async {

    final file =
        await _localFile(fileName);

    final jsonString =
        jsonEncode(blocks);

    await file.writeAsString(
      jsonString,
    );

    print(
      'LESSON SAVED -> ${file.path}',
    );

  }

  // LOAD LESSON
  static Future<List<dynamic>>
      loadLesson(
    String fileName,
  ) async {

    try {

      final file =
          await _localFile(fileName);

      final contents =
          await file.readAsString();

      return jsonDecode(contents);

    } catch (e) {

      print(
        'LOAD ERROR: $e',
      );

      return [];

    }

  }

}