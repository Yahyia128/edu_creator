import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class NestedImageBlockWidget
    extends StatefulWidget {

  final Map<String, dynamic> block;

  final VoidCallback onDelete;

  final Future<void> Function()
      onPickImage;

  const NestedImageBlockWidget({

    super.key,

    required this.block,

    required this.onDelete,

    required this.onPickImage,

  });

  @override
  State<NestedImageBlockWidget>
      createState() =>
          _NestedImageBlockWidgetState();
}

class _NestedImageBlockWidgetState
    extends State<
        NestedImageBlockWidget> {

  @override
  Widget build(BuildContext context) {

    Uint8List? imageBytes;

    if (widget.block[
            'imageBase64'] !=
        null) {

      imageBytes = base64Decode(

        widget.block['imageBase64'],

      );

    }

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

                  onPressed:
                      widget.onDelete,

                  icon: const Icon(
                    Icons.delete,
                  ),

                ),

              ],

            ),

            SizedBox(

              width: double.infinity,

              height: 180,

              child: ElevatedButton(

                onPressed: () async {

                  await widget
                      .onPickImage();

                  setState(() {});

                },

                child:
                    imageBytes != null

                        ? Image.memory(

                            imageBytes,

                            fit: BoxFit.cover,

                            width:
                                double.infinity,

                          )

                        : const Column(

                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,

                            children: [

                              Icon(
                                Icons.image,
                                size: 40,
                              ),

                              SizedBox(
                                  height: 8),

                              Text(
                                'Pick Image',
                              ),

                            ],

                          ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}