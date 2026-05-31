import 'package:flutter/material.dart';

class AudioBlockWidget extends StatelessWidget {

  final Map block;

  final bool isRecording;

  final VoidCallback onDelete;

  final VoidCallback onRecord;

  final VoidCallback onPlay;

  const AudioBlockWidget({

    super.key,

    required this.block,

    required this.isRecording,

    required this.onDelete,

    required this.onRecord,

    required this.onPlay,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Row(

              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                IconButton(

                  onPressed: onDelete,

                  icon: const Icon(Icons.delete),

                ),

              ],

            ),

            const SizedBox(height: 20),

            Row(

              mainAxisAlignment:

                  MainAxisAlignment.center,

              children: [

                IconButton(

                  onPressed: onRecord,

                  icon: Icon(

                    isRecording
                        ? Icons.stop
                        : Icons.mic,

                    size: 40,

                  ),

                ),

                const SizedBox(width: 20),

                IconButton(

                  onPressed: onPlay,

                  icon: const Icon(

                    Icons.play_arrow,

                    size: 40,

                  ),

                ),

              ],

            ),

            const SizedBox(height: 10),

            Text(

              block['audioPath'] == ''

                  ? 'No audio recorded'

                  : 'Audio ready',

            ),

          ],

        ),

      ),

    );

  }

}