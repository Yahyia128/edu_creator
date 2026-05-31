import 'package:flutter/material.dart';

class NestedQuizBlockWidget
    extends StatefulWidget {

  final Map<String, dynamic> block;

  final VoidCallback onDelete;

  final VoidCallback onUpdate;

  const NestedQuizBlockWidget({

    super.key,

    required this.block,

    required this.onDelete,

    required this.onUpdate,

  });

  @override
  State<NestedQuizBlockWidget>
      createState() =>
          _NestedQuizBlockWidgetState();
}

class _NestedQuizBlockWidgetState
    extends State<
        NestedQuizBlockWidget> {

  @override
  Widget build(BuildContext context) {

    final question =
        widget.block['questions'][0];

    return Card(

      margin:
          const EdgeInsets.only(
              bottom: 12),

      child: Padding(

        padding:
            const EdgeInsets.all(12),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

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

            const Text(

              'QUIZ GROUP',

              style: TextStyle(

                fontWeight:
                    FontWeight.bold,

                fontSize: 12,

                color: Colors.grey,

              ),

            ),

            const SizedBox(height: 8),

            TextField(

              decoration:
                  const InputDecoration(

                hintText: 'Question',

              ),

              onChanged: (value) {

                question['question'] =
                    value;

                widget.onUpdate();

              },

            ),

            const SizedBox(height: 12),

            ...List.generate(

              question['options']
                  .length,

              (optionIndex) {

                return RadioListTile(

                  value: optionIndex,

                  groupValue:
                      question[
                          'correctAnswer'],

                  title: Row(

                    children: [

                      Expanded(

                        child: TextField(

                          decoration:
                              InputDecoration(

                            hintText:
                                'Option ${optionIndex + 1}',

                          ),

                          onChanged: (value) {

                            question['options']
                                    [optionIndex] =
                                value;

                            widget.onUpdate();

                          },

                        ),

                      ),

                      if (question[
                              'correctAnswer'] ==
                          optionIndex)

                        const Padding(

                          padding:
                              EdgeInsets.only(
                                  left: 8),

                          child: Icon(

                            Icons.check_circle,

                            color: Colors.green,

                          ),

                        ),

                    ],

                  ),

                  onChanged: (value) {

                    setState(() {

                      question[
                          'correctAnswer'] =
                          value as int;

                    });

                    widget.onUpdate();

                  },

                );

              },

            ),

          ],

        ),

      ),

    );

  }

}