import 'package:flutter/material.dart';

import 'nested_text_block_widget.dart';
import 'nested_quiz_block_widget.dart';
import 'nested_image_block_widget.dart';
import 'nested_audio_block_widget.dart';

class LessonGroupWidget
    extends StatefulWidget {

  final Map<String, dynamic> block;

  final VoidCallback onDelete;

  final Future<void> Function(
    int childIndex,
  ) onPickImage;

  final VoidCallback onUpdate;

  const LessonGroupWidget({

    super.key,

    required this.block,

    required this.onDelete,

    required this.onPickImage,

    required this.onUpdate,

  });

  @override
  State<LessonGroupWidget>
      createState() =>
          _LessonGroupWidgetState();
}

class _LessonGroupWidgetState
    extends State<LessonGroupWidget> {

  @override
  Widget build(BuildContext context) {

    return Card(

      margin:
          const EdgeInsets.only(
              bottom: 16),

      child: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(

              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                const Text(

                  'Lesson Group',

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

                IconButton(

                  onPressed:
                      widget.onDelete,

                  icon: const Icon(
                    Icons.delete,
                  ),

                ),

              ],

            ),

            const SizedBox(height: 12),

            TextField(

              decoration:
                  const InputDecoration(

                hintText:
                    'Lesson Title',

              ),

              onChanged: (value) {

                widget.block['title'] =
                    value;

                widget.onUpdate();

              },

            ),

            const SizedBox(height: 16),

            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                      16),

              decoration: BoxDecoration(

                color:
                    Colors.grey.shade200,

                borderRadius:
                    BorderRadius.circular(
                        12),

              ),

              child: Column(

                children: [

                  const Icon(

                    Icons.menu_book,

                    size: 40,

                  ),

                  const SizedBox(
                      height: 8),

                  Text(

                    '${widget.block['children'].length} Blocks Inside',

                  ),

                  const SizedBox(
                      height: 16),

                  PopupMenuButton<String>(

                    onSelected: (type) {

                      setState(() {

                        // TEXT
                        if (type ==
                            'text') {

                          widget.block[
                                  'children']
                              .add({

                            'type':
                                'text',

                            'text': '',

                          });

                        }

                        // QUIZ
                        if (type ==
                            'quiz') {

                          widget.block[
                                  'children']
                              .add({

                            'type':
                                'quiz_group',

                            'questions': [

                              {

                                'question':
                                    '',

                                'options': [

                                  '',
                                  '',

                                ],

                                'correctAnswer':
                                    0,

                              }

                            ],

                          });

                        }

                        // IMAGE
                        if (type ==
                            'image') {

                          widget.block[
                                  'children']
                              .add({

                            'type':
                                'image',

                            'imageBytes':
                                null,

                          });

                        }

                        // AUDIO
                        if (type ==
                            'audio') {

                          widget.block[
                                  'children']
                              .add({

                            'type':
                                'audio',

                            'audioPath':
                                '',

                            'isRecording':
                                false,

                            'hasAudio':
                                false,

                          });

                        }

                      });

                      widget.onUpdate();

                    },

                    itemBuilder:
                        (context) => [

                      const PopupMenuItem(

                        value: 'text',

                        child:
                            Text('Text'),

                      ),

                      const PopupMenuItem(

                        value: 'quiz',

                        child:
                            Text('Quiz'),

                      ),

                      const PopupMenuItem(

                        value: 'image',

                        child:
                            Text('Image'),

                      ),

                      const PopupMenuItem(

                        value: 'audio',

                        child:
                            Text('Audio'),

                      ),

                    ],

                    child: Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 16,
                        vertical: 12,

                      ),

                      decoration:
                          BoxDecoration(

                        color: Colors.blue,

                        borderRadius:
                            BorderRadius.circular(
                                12),

                      ),

                      child: Row(

                        mainAxisSize:
                            MainAxisSize.min,

                        children: [

                          const Icon(

                            Icons.add,

                            color:
                                Colors.white,

                          ),

                          const SizedBox(
                              width: 8),

                          const Text(

                            'Add Block',

                            style: TextStyle(

                              color:
                                  Colors.white,

                            ),

                          ),

                        ],

                      ),

                    ),

                  ),

                  const SizedBox(
                      height: 16),

                  ...List.generate(

                    widget.block[
                            'children']
                        .length,

                    (index) {

                      final child =
                          widget.block[
                              'children'][index];

                      final childKey =
                          ValueKey(

                        '${child['type']}_$index'
                        '_${child['isRecording']}'
                        '_${child['hasAudio']}',

                      );

                      // TEXT
                      if (child['type'] ==
                          'text') {

                        return NestedTextBlockWidget(

                          block: child,

                          onDelete: () {

                            setState(() {

                              widget.block[
                                      'children']
                                  .removeAt(
                                      index);

                            });

                            widget
                                .onUpdate();

                          },

                          onUpdate: () {

                            widget
                                .onUpdate();

                          },

                        );

                      }

                      // QUIZ
                      if (child['type'] ==
                          'quiz_group') {

                        return NestedQuizBlockWidget(

                          block: child,

                          onDelete: () {

                            setState(() {

                              widget.block[
                                      'children']
                                  .removeAt(
                                      index);

                            });

                            widget
                                .onUpdate();

                          },

                          onUpdate: () {

                            widget
                                .onUpdate();

                          },

                        );

                      }

                      // IMAGE
                      if (child['type'] ==
                          'image') {

                        return NestedImageBlockWidget(

                          block: child,

                          onDelete: () {

                            setState(() {

                              widget.block[
                                      'children']
                                  .removeAt(
                                      index);

                            });

                            widget
                                .onUpdate();

                          },

                          onPickImage:
                              () async {

                            await widget
                                .onPickImage(
                              index,
                            );

                            setState(() {});

                          },

                        );

                      }

                      // AUDIO
                      if (child['type'] ==
                          'audio') {

                        return KeyedSubtree(

                          key: childKey,

                          child:
                              NestedAudioBlockWidget(

                            isRecording:
                                child['isRecording'],

                            hasAudio:
                                child['hasAudio'],

                            onDelete: () {

                              setState(() {

                                widget.block[
                                        'children']
                                    .removeAt(
                                        index);

                              });

                              widget
                                  .onUpdate();

                            },

                            onRecord: () {

                              setState(() {

                                bool recording =
                                    child['isRecording'];

                                child['isRecording'] =
                                    !recording;

                                if (recording) {

                                  child['hasAudio'] =
                                      true;

                                }

                              });

                              widget.onUpdate();

                            },

                            onPlay: () {

                              print(
                                'PLAY AUDIO',
                              );

                            },

                          ),

                        );

                      }

                      return const SizedBox();

                    },

                  ),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }

}