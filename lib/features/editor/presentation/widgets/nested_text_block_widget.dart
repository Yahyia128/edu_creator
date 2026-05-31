import 'package:flutter/material.dart';

class NestedTextBlockWidget
    extends StatelessWidget {

  final Map<String, dynamic> block;

  final VoidCallback onDelete;

  final VoidCallback onUpdate;

  const NestedTextBlockWidget({

    super.key,

    required this.block,

    required this.onDelete,

    required this.onUpdate,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin:
          const EdgeInsets.only(
              bottom: 12),

      child: Padding(

        padding:
            const EdgeInsets.all(12),

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

            const Align(

              alignment:
                  Alignment.centerLeft,

              child: Text(

                'TEXT BLOCK',

                style: TextStyle(

                  fontWeight:
                      FontWeight.bold,

                  fontSize: 12,

                  color: Colors.grey,

                ),

              ),

            ),

            const SizedBox(height: 8),

            TextField(

              decoration:
                  const InputDecoration(

                hintText:
                    'Nested Text Block',

              ),

              onChanged: (value) {

                block['text'] = value;

                onUpdate();

              },

            ),

          ],

        ),

      ),

    );

  }

}