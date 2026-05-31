import 'package:flutter/material.dart';

class QuizBlockWidget extends StatefulWidget {

  final Map<String, dynamic> block;

  final int index;

  final VoidCallback onDelete;

  final VoidCallback onUpdate;

  const QuizBlockWidget({

    super.key,

    required this.block,

    required this.index,

    required this.onDelete,

    required this.onUpdate,

  });

  @override
  State<QuizBlockWidget> createState() =>
      _QuizBlockWidgetState();
}

class _QuizBlockWidgetState
    extends State<QuizBlockWidget> {

  @override
  Widget build(BuildContext context) {

    final questions =
        widget.block['questions'];

    return Card(

      margin: const EdgeInsets.only(
        bottom: 16,
      ),

      child: Padding(

        padding: const EdgeInsets.all(
          16,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(

                  'Quiz Group',

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

            const SizedBox(
              height: 16,
            ),

            ...List.generate(

              questions.length,

              (questionIndex) {

                final question =
                    questions[
                        questionIndex];

                question['data'] ??= {

                  'options': [

                    '',
                    '',

                  ],

                  'correctAnswer': 0,

                };

                question['data']['options']
                    ??= ['', ''];

                question['data']
                        ['correctAnswer']
                    ??= 0;

                return Card(

                  margin:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),

                  child: Padding(

                    padding:
                        const EdgeInsets.all(
                      12,
                    ),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        // HEADER
                        Row(

                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            Text(

                              'Question ${questionIndex + 1}',

                              style:
                                  const TextStyle(

                                fontSize: 16,

                                fontWeight:
                                    FontWeight
                                        .bold,

                              ),

                            ),

                            IconButton(

                              onPressed: () {

                                setState(() {

                                  questions.removeAt(
                                    questionIndex,
                                  );

                                });

                                widget.onUpdate();

                              },

                              icon:
                                  const Icon(
                                Icons.delete,
                              ),

                            ),

                          ],

                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        // QUESTION FIELD
                        TextField(

                          textDirection:
                              TextDirection.rtl,

                          textAlign:
                              TextAlign.right,

                          keyboardType:
                              TextInputType.multiline,

                          decoration:
                              const InputDecoration(

                            hintText:
                                'Question',

                            border:
                                OutlineInputBorder(),

                          ),

                          onChanged:
                              (value) {

                            question[
                                    'question'] =
                                value;

                            widget
                                .onUpdate();

                          },

                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        // QUESTION TYPE
                        DropdownButtonFormField<String>(

                          value:
                              question['type'],

                          decoration:
                              const InputDecoration(

                            border:
                                OutlineInputBorder(),

                          ),

                          items: const [

                            DropdownMenuItem(

                              value:
                                  'multiple_choice',

                              child: Text(
                                'Multiple Choice',
                              ),

                            ),

                            DropdownMenuItem(

                              value:
                                  'true_false',

                              child: Text(
                                'True / False',
                              ),

                            ),

                          ],

                          onChanged: (value) {

                            setState(() {

                              question['type'] =
                                  value;

                            });

                            widget.onUpdate();

                          },

                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        // MULTIPLE CHOICE
                        if (question['type'] ==
                            'multiple_choice')

                          Column(

                            children: [

                              ...List.generate(

                                question['data']
                                        ['options']
                                    .length,

                                (optionIndex) {

                                  return Container(

                                    margin:
                                        const EdgeInsets.only(
                                      bottom:
                                          12,
                                    ),

                                    child:
                                        Row(

                                      children: [

                                        Radio<int>(

                                          value:
                                              optionIndex,

                                          groupValue:
                                              question['data']
                                                      [
                                                      'correctAnswer'],

                                          onChanged:
                                              (
                                            value,
                                          ) {

                                            setState(() {

                                              question['data']
                                                      [
                                                      'correctAnswer'] =
                                                  value;

                                            });

                                            widget
                                                .onUpdate();

                                          },

                                        ),

                                        Expanded(

                                          child:
                                              TextField(

                                            textDirection:
                                                TextDirection.rtl,

                                            textAlign:
                                                TextAlign.right,

                                            keyboardType:
                                                TextInputType.multiline,

                                            decoration:
                                                InputDecoration(

                                              hintText:
                                                  'Option ${optionIndex + 1}',

                                              border:
                                                  const OutlineInputBorder(),

                                            ),

                                            onChanged:
                                                (
                                              value,
                                            ) {

                                              question['data']
                                                      [
                                                      'options'][optionIndex] =
                                                  value;

                                              widget
                                                  .onUpdate();

                                            },

                                          ),

                                        ),

                                        IconButton(

                                          onPressed:
                                              () {

                                            setState(
                                                () {

                                              question['data']
                                                      [
                                                      'options']
                                                  .removeAt(
                                                optionIndex,
                                              );

                                            });

                                            widget
                                                .onUpdate();

                                          },

                                          icon:
                                              const Icon(
                                            Icons
                                                .close,
                                          ),

                                        ),

                                      ],

                                    ),

                                  );

                                },

                              ),

                              ElevatedButton(

                                onPressed:
                                    () {

                                  setState(() {

                                    question['data']
                                            [
                                            'options']
                                        .add('');

                                  });

                                  widget
                                      .onUpdate();

                                },

                                child:
                                    const Text(
                                  'Add Option',
                                ),

                              ),

                            ],

                          ),

                        // TRUE FALSE
                        if (question['type'] ==
                            'true_false')

                          Column(

                            children: [

                              RadioListTile<bool>(

                                value: true,

                                groupValue:
                                    question[
                                            'data']
                                        [
                                        'correctAnswer'],

                                title:
                                    const Text(
                                  'True',
                                ),

                                onChanged:
                                    (
                                  value,
                                ) {

                                  setState(() {

                                    question['data']
                                            [
                                            'correctAnswer'] =
                                        true;

                                  });

                                  widget
                                      .onUpdate();

                                },

                              ),

                              RadioListTile<bool>(

                                value: false,

                                groupValue:
                                    question[
                                            'data']
                                        [
                                        'correctAnswer'],

                                title:
                                    const Text(
                                  'False',
                                ),

                                onChanged:
                                    (
                                  value,
                                ) {

                                  setState(() {

                                    question['data']
                                            [
                                            'correctAnswer'] =
                                        false;

                                  });

                                  widget
                                      .onUpdate();

                                },

                              ),

                            ],

                          ),

                      ],

                    ),

                  ),

                );

              },

            ),

            const SizedBox(
              height: 16,
            ),

            // ADD QUESTION
            ElevatedButton(

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
                              Icons.radio_button_checked,
                            ),

                            title: const Text(
                              'Multiple Choice',
                            ),

                            onTap: () {

                              Navigator.pop(
                                context,
                              );

                              setState(() {

                                questions.add({

                                  'type':
                                      'multiple_choice',

                                  'question': '',

                                  'data': {

                                    'options': [

                                      '',
                                      '',

                                    ],

                                    'correctAnswer': 0,

                                  },

                                });

                              });

                              widget
                                  .onUpdate();

                            },

                          ),

                          ListTile(

                            leading: const Icon(
                              Icons.check,
                            ),

                            title: const Text(
                              'True / False',
                            ),

                            onTap: () {

                              Navigator.pop(
                                context,
                              );

                              setState(() {

                                questions.add({

                                  'type':
                                      'true_false',

                                  'question': '',

                                  'data': {

                                    'correctAnswer':
                                        true,

                                  },

                                });

                              });

                              widget
                                  .onUpdate();

                            },

                          ),

                        ],

                      ),

                    );

                  },

                );

              },

              child: const Text(
                'Add Question',
              ),

            ),

          ],

        ),

      ),

    );

  }

}