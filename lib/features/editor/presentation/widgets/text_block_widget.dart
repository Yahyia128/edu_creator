import 'package:flutter/material.dart';

class TextBlockWidget
    extends StatefulWidget {

  final Map<String, dynamic> block;

  final VoidCallback onDelete;

  final VoidCallback onUpdate;

  const TextBlockWidget({

    super.key,

    required this.block,

    required this.onDelete,

    required this.onUpdate,

  });

  @override
  State<TextBlockWidget>
      createState() =>
          _TextBlockWidgetState();

}

class _TextBlockWidgetState
    extends State<TextBlockWidget> {

  late TextEditingController controller;

  @override
  void initState() {

    super.initState();

    controller = TextEditingController(

      text:
          widget.block['text'] ?? '',

    );

  }

  @override
  void didUpdateWidget(

    covariant TextBlockWidget
        oldWidget,

  ) {

    super.didUpdateWidget(
      oldWidget,
    );

    final newText =
        widget.block['text'] ?? '';

    if (controller.text !=
        newText) {

      controller.text = newText;

    }

  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Card(

      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: Padding(

        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Column(

          children: [

            Row(

              mainAxisAlignment:
                  MainAxisAlignment
                      .end,

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

            TextField(

              controller:
                  controller,

              maxLines: null,

              decoration:
                  const InputDecoration(

                hintText:
                    'Write lesson text...',

                border:
                    OutlineInputBorder(),

              ),

              onChanged: (value) {

                widget.block['text'] =
                    value;

                widget.onUpdate();

              },

            ),

          ],

        ),

      ),

    );

  }

}