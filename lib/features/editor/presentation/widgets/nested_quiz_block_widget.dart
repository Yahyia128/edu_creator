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
            // بعد السطر const SizedBox(height: 8)، أضف هذا:
DropdownButtonFormField<String>(
  value: question['type'] ?? 'multiple_choice',
  items: const [
    DropdownMenuItem(value: 'multiple_choice', child: Text('Multiple Choice')),
    DropdownMenuItem(value: 'true_false', child: Text('True/False')),
    DropdownMenuItem(value: 'written', child: Text('Written')),
  ],
  onChanged: (value) {
    setState(() {
      question['type'] = value;
      // إعادة تعيين الهيكل حسب النوع
      if (value == 'true_false') {
        question['options'] = ['True', 'False'];
        question['correctAnswer'] = 0; // 0 = True
      } else if (value == 'written') {
        question['options'] = [];
        question['correctAnswer'] = '';
      }
    });
    widget.onUpdate();
  },
  decoration: const InputDecoration(
    labelText: 'Question Type',
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 12),

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

           // Multiple Choice Options (فقط إذا كان النوع multiple_choice)
if (question['type'] == 'multiple_choice')
  Column(
    children: [
      ...List.generate(
        question['options'].length,
        (optionIndex) => RadioListTile<int>(
          value: optionIndex,
          groupValue: question['correctAnswer'],
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Option ${optionIndex + 1}',
            ),
            onChanged: (value) {
              question['options'][optionIndex] = value;
              widget.onUpdate();
            },
          ),
          onChanged: (value) {
            setState(() {
              question['correctAnswer'] = value;
            });
            widget.onUpdate();
          },
        ),
      ),
      TextButton(
        onPressed: () {
          setState(() {
            question['options'].add('New Option');
          });
          widget.onUpdate();
        },
        child: const Text('+ Add Option'),
      ),
    ],
  ),

// True/False (لا يحتاج خيارات)
if (question['type'] == 'true_false')
  const Text('True/False: User will see True/False options',
             style: TextStyle(color: Colors.grey)),

// Written (لا يحتاج خيارات)
if (question['type'] == 'written')
  const Text('Written: User will type their answer',
             style: TextStyle(color: Colors.grey)),

          ],

        ),

      ),

    );

  }

}