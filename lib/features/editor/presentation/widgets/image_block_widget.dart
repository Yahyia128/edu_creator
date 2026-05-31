import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageBlockWidget
    extends StatelessWidget {

  final Map<String, dynamic> block;

  final VoidCallback onDelete;

  final VoidCallback onPickImage;

  const ImageBlockWidget({

    super.key,

    required this.block,

    required this.onDelete,

    required this.onPickImage,

  });

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

            GestureDetector(

              onTap: onPickImage,

              child: Container(

                width: double.infinity,

                height: 220,

                decoration: BoxDecoration(

                  color:
                      Colors.grey.shade300,

                  borderRadius:
                      BorderRadius.circular(
                          16),

                ),

                child:
                    block['imageBytes'] !=
                            null

                        ? ClipRRect(

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        16),

                            child: Image.memory(

                              Uint8List.fromList(

                                List<int>.from(

                                  block[
                                      'imageBytes'],

                                ),

                              ),

                              fit: BoxFit.cover,

                            ),

                          )

                        : const Column(

                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,

                            children: [

                              Icon(

                                Icons.image,

                                size: 50,

                              ),

                              SizedBox(
                                  height: 12),

                              Text(

                                'Tap To Pick Image',

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