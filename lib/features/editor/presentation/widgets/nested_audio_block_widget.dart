import 'package:flutter/material.dart';

class NestedAudioBlockWidget
    extends StatelessWidget {

  final VoidCallback onDelete;

  final VoidCallback onRecord;

  final VoidCallback onPlay;

  final bool isRecording;

  final bool hasAudio;

  const NestedAudioBlockWidget({

    super.key,

    required this.onDelete,

    required this.onRecord,

    required this.onPlay,

    required this.isRecording,

    required this.hasAudio,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin:
          const EdgeInsets.only(
              bottom: 12),

      child: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          children: [

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.end,

              children: [

                IconButton(

                  onPressed: onDelete,

                  icon: const Icon(
                    Icons.delete,
                  ),

                ),

              ],

            ),

            const Icon(

              Icons.mic,

              size: 50,

            ),

            const SizedBox(height: 12),

            Text(

              isRecording
                  ? 'Recording...'
                  : 'Audio Block',

            ),

            const SizedBox(height: 16),

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                ElevatedButton.icon(

                  onPressed: onRecord,

                  icon: Icon(

                    isRecording
                        ? Icons.stop
                        : Icons.mic,

                  ),

                  label: Text(

                    isRecording
                        ? 'Stop'
                        : 'Record',

                  ),

                ),

                const SizedBox(width: 12),

                ElevatedButton.icon(

                  onPressed:
                      hasAudio
                          ? onPlay
                          : null,

                  icon: const Icon(
                    Icons.play_arrow,
                  ),

                  label: const Text(
                    'Play',
                  ),

                ),

              ],

            ),

          ],

        ),

      ),

    );

  }

}