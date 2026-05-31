import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lesson_preview_screen.dart';

import 'widgets/text_block_widget.dart';
import 'widgets/image_block_widget.dart';
import 'widgets/quiz_block_widget.dart';
import 'widgets/audio_block_widget.dart';
import 'widgets/lesson_group_widget.dart';
class EditorScreen extends StatefulWidget {

  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() =>
      _EditorScreenState();

}

class _EditorScreenState
    extends State<EditorScreen> {

  final List<Map<String, dynamic>>
      blocks = [];

  final ImagePicker picker =
      ImagePicker();

  final AudioRecorder audioRecorder =
      AudioRecorder();

  final AudioPlayer audioPlayer =
      AudioPlayer();

  bool isRecording = false;
  
@override
void initState() {

  super.initState();

  loadLesson();

}

Future<void> saveLesson() async {

  final prefs =
      await SharedPreferences.getInstance();

  final data = jsonEncode(blocks);

  await prefs.setString(
    'lesson_data',
    data,
  );

  print('LESSON SAVED');

}

Future<void> loadLesson() async {

  final prefs =
      await SharedPreferences.getInstance();

  final data =
      prefs.getString('lesson_data');

  if (data != null) {

    final decoded =
        jsonDecode(data);

    setState(() {

      blocks.clear();

      blocks.addAll(
        List<Map<String, dynamic>>.from(
          decoded,
        ),
      );

    });

    print('LESSON LOADED');

  }

}



  // PLAY AUDIO
  Future<void> playAudio(
      String path) async {

    if (path.isNotEmpty) {

      await audioPlayer.play(

        DeviceFileSource(path),

      );

    }

  }

  // RECORD AUDIO
  Future<void> toggleRecording(
      int index) async {

    if (isRecording) {

      await audioRecorder.stop();

      blocks[index]['audioPath'] =
          'audio_$index.m4a';

      setState(() {

        isRecording = false;

      });

    } else {

      if (await audioRecorder
          .hasPermission()) {

        await audioRecorder.start(

          const RecordConfig(),

          path: 'audio_$index.m4a',

        );

        setState(() {

          isRecording = true;

        });

      }

    }

  }

  // ADD BLOCK
  void addBlock(String type) {

    setState(() {

      // TEXT BLOCK
      if (type == 'text') {

        blocks.add({

          'type': 'text',

          'text': '',

        });

      }

      // QUIZ GROUP
      if (type == 'quiz_group') {

        blocks.add({

          'type': 'quiz_group',

          'questions': [

            {

              'question': '',

              'options': [

                '',
                '',

              ],

              'correctAnswer': 0,

            }

          ],

        });

      }

      // LESSON GROUP
      if (type == 'lesson_group') {

        blocks.add({

          'type': 'lesson_group',

          'title': '',

          'children': [],

        });

      }

      // IMAGE BLOCK
      if (type == 'image') {

        blocks.add({

          'type': 'image',

          'imageBytes': null,

        });

      }

      // AUDIO BLOCK
      if (type == 'audio') {

        blocks.add({

          'type': 'audio',

          'audioPath': '',

        });

      }

    });

  }

  // PICK NESTED IMAGE
  Future<void> pickNestedImage(

    int parentIndex,
    int childIndex,

  ) async {

    final XFile? image =
        await picker.pickImage(

      source: ImageSource.gallery,

    );

    if (image != null) {

      final bytes =
          await image.readAsBytes();

      final base64Image =
          base64Encode(bytes);

      setState(() {

        blocks[parentIndex]
                ['children'][childIndex]
            ['imageBase64'] =
                base64Image;

      });

    }

  }

  // PICK IMAGE
  Future<void> pickImage(
      int index) async {

    final XFile? image =
        await picker.pickImage(

      source: ImageSource.gallery,

    );

    if (image != null) {

      final bytes =
          await image.readAsBytes();

      final base64Image =
          base64Encode(bytes);

      setState(() {

        blocks[index]['imageBase64'] =
            base64Image;

      });

    }

  }

  @override
  void dispose() {

    audioRecorder.dispose();

    audioPlayer.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

  title: const Text(
    'Lesson Editor',
  ),

  actions: [
  
IconButton(

  onPressed: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>

            LessonPreviewScreen(

          blocks: blocks,

        ),

      ),

    );

  },

  icon: const Icon(
    Icons.visibility,
  ),

),

  IconButton(

    onPressed: saveLesson,

    icon: const Icon(
      Icons.save,
    ),

  ),

  IconButton(

    onPressed: () {

      Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) =>
              LessonPreviewScreen(

            blocks: blocks,

          ),

        ),

      );

    },

    icon: const Icon(
      Icons.visibility,
    ),

  ),

],

),

      body: ListView.builder(

        padding:
            const EdgeInsets.all(16),

        itemCount: blocks.length,

        itemBuilder:
            (context, index) {

          final block = blocks[index];

          // TEXT BLOCK
          if (block['type'] ==
              'text') {

            return TextBlockWidget(

              block: block,

              onDelete: () {

                setState(() {

                  blocks.removeAt(index);

                });

              },

              onUpdate: () {

                setState(() {});

              },

            );

          }

          // QUIZ GROUP
          if (block['type'] ==
              'quiz_group') {

            return QuizBlockWidget(

              block: block,

              index: index,

              onDelete: () {

                setState(() {

                  blocks.removeAt(index);

                });

              },

              onUpdate: () {

                setState(() {});

              },

            );

          }

          // LESSON GROUP
          if (block['type'] ==
              'lesson_group') {

            return LessonGroupWidget(

              block: block,

              onDelete: () {

                setState(() {

                  blocks.removeAt(index);

                });

              },

              onPickImage:
                  (childIndex) async {

                await pickNestedImage(

                  index,
                  childIndex,

                );

              },

              onUpdate: () {

                setState(() {});

              },

            );

          }

          // IMAGE BLOCK
          if (block['type'] ==
              'image') {

            return ImageBlockWidget(

              block: block,

              onDelete: () {

                setState(() {

                  blocks.removeAt(index);

                });

              },

              onPickImage: () {

                pickImage(index);

              },

            );

          }

          // AUDIO BLOCK
          if (block['type'] ==
              'audio') {

            return AudioBlockWidget(

              block: block,

              isRecording:
                  isRecording,

              onDelete: () {

                setState(() {

                  blocks.removeAt(index);

                });

              },

              onRecord: () {

                toggleRecording(
                    index);

              },

              onPlay: () {

                playAudio(

                  block['audioPath'],

                );

              },

            );

          }

          return const SizedBox();

        },

      ),

      floatingActionButton:
          FloatingActionButton(

        child:
            const Icon(Icons.add),

        onPressed: () {

          showModalBottomSheet(

            context: context,

            builder: (context) {

              return SafeArea(

                child: Column(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    ListTile(

                      leading: const Icon(
                        Icons.menu_book,
                      ),

                      title: const Text(
                        'Lesson Group',
                      ),

                      onTap: () {

                        Navigator.pop(
                            context);

                        addBlock(
                            'lesson_group');

                      },

                    ),

                    ListTile(

                      leading: const Icon(
                        Icons.text_fields,
                      ),

                      title: const Text(
                        'Text Block',
                      ),

                      onTap: () {

                        Navigator.pop(
                            context);

                        addBlock(
                            'text');

                      },

                    ),

                    ListTile(

                      leading: const Icon(
                        Icons.quiz,
                      ),

                      title: const Text(
                        'Quiz Group',
                      ),

                      onTap: () {

                        Navigator.pop(
                            context);

                        addBlock(
                            'quiz_group');

                      },

                    ),

                    ListTile(

                      leading: const Icon(
                        Icons.image,
                      ),

                      title: const Text(
                        'Image Block',
                      ),

                      onTap: () {

                        Navigator.pop(
                            context);

                        addBlock(
                            'image');

                      },

                    ),

                    ListTile(

                      leading: const Icon(
                        Icons.mic,
                      ),

                      title: const Text(
                        'Audio Block',
                      ),

                      onTap: () {

                        Navigator.pop(
                            context);

                        addBlock(
                            'audio');

                      },

                    ),

                  ],

                ),

              );

            },

          );

        },

      ),

    );

  }

}