import 'dart:convert';

import 'package:flutter/material.dart';

class LessonPreviewScreen extends StatefulWidget {
  final List<Map<String, dynamic>> blocks;

  const LessonPreviewScreen({super.key, required this.blocks});

  @override
  State<LessonPreviewScreen> createState() => _LessonPreviewScreenState();
}

class _LessonPreviewScreenState extends State<LessonPreviewScreen> {
  final Map<String, dynamic> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lesson Preview')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.blocks.length,
        itemBuilder: (context, index) {
          final block = widget.blocks[index];
          @override
Widget build(BuildContext context) {
  // أضف هذين السطرين للتأكد من البيانات
  print('=== DATA DEBUG ===');
  print(jsonEncode(widget.blocks));
  
  return Scaffold(
    // ... باقي الكود
  );
}

          // TEXT
          if (block['type'] == 'text') {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Text(
                block['text'] ?? '',
                style: const TextStyle(fontSize: 18),
              ),
            );
          }

          // IMAGE
          if (block['type'] == 'image') {
            if (block['imageBase64'] == null) {
              return const SizedBox();
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(base64Decode(block['imageBase64'])),
              ),
            );
          }

          // QUIZ GROUP
          if (block['type'] == 'quiz_group') {
            return Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quiz',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(block['questions'].length, (questionIndex) {
                    final question = block['questions'][questionIndex];
                    final answerKey = '${index}_$questionIndex';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // السؤال
                          Text(
                            question['question'] ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                         // MULTIPLE CHOICE - مرن لأي هيكل بيانات
if (question['type'] == 'multiple_choice')
  Column(
    children: [
      // جرب ناخد الخيارات من أكتر من مكان محتمل
      final options = question['options'] ?? 
                      question['data']?['options'] ?? 
                      question['choices'] ?? 
                      [];
      ...List.generate(options.length, (optionIndex) {
        final optionText = options[optionIndex].toString();
        return RadioListTile<int>(
          value: optionIndex,
          groupValue: selectedAnswers[answerKey],
          title: Text(optionText),
          onChanged: (value) {
            setState(() {
              selectedAnswers[answerKey] = value;
            });
          },
        );
      }),
    ],
  ),

                          // ========== 2. TRUE/FALSE ==========
                          if (question['type'] == 'true_false')
                            Column(
                              children: [
                                RadioListTile<bool>(
                                  value: true,
                                  groupValue: selectedAnswers[answerKey],
                                  title: const Text('True'),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswers[answerKey] = value;
                                    });
                                  },
                                ),
                                RadioListTile<bool>(
                                  value: false,
                                  groupValue: selectedAnswers[answerKey],
                                  title: const Text('False'),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswers[answerKey] = value;
                                    });
                                  },
                                ),
                              ],
                            ),

// MULTIPLE CHOICE - مرن لأي هيكل بيانات
if (question['type'] == 'multiple_choice')
  Column(
    children: [
      // جرب ناخد الخيارات من أكتر من مكان محتمل
      final options = question['options'] ?? 
                      question['data']?['options'] ?? 
                      question['choices'] ?? 
                      [];
      ...List.generate(options.length, (optionIndex) {
        final optionText = options[optionIndex].toString();
        return RadioListTile<int>(
          value: optionIndex,
          groupValue: selectedAnswers[answerKey],
          title: Text(optionText),
          onChanged: (value) {
            setState(() {
              selectedAnswers[answerKey] = value;
            });
          },
        );
      }),
    ],
  ),

                          const SizedBox(height: 12),

                          // ========== زر CHECK ANSWER ==========
                          ElevatedButton(
                            onPressed: () {
                              final userAnswer = selectedAnswers[answerKey];
                              final correctAnswer = question['correctAnswer'];

                              // التحقق من وجود الإجابة الصحيحة
                              if (correctAnswer == null) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Error'),
                                    content: Text(
                                      'Missing correct answer for question:\n${question['question']}',
                                    ),
                                  ),
                                );
                                return;
                              }

                              // معالجة الإجابة حسب نوع السؤال
                              bool isCorrect = false;
                              String displayAnswer = correctAnswer.toString();

                              if (question['type'] == 'multiple_choice') {
                                isCorrect = userAnswer == correctAnswer;
                                displayAnswer = question['options']?[correctAnswer] ?? correctAnswer.toString();
                              } 
                              else if (question['type'] == 'true_false') {
                                isCorrect = userAnswer == correctAnswer;
                                displayAnswer = correctAnswer ? 'True' : 'False';
                              }
                              else if (question['type'] == 'written') {
                                isCorrect = userAnswer?.toString().trim().toLowerCase() == 
                                            correctAnswer.toString().trim().toLowerCase();
                                displayAnswer = correctAnswer.toString();
                              }

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(isCorrect ? '✓ Correct!' : '✗ Wrong'),
                                  content: Text(
                                    isCorrect 
                                      ? 'Good Job!' 
                                      : 'Correct Answer: $displayAnswer',
                                  ),
                                ),
                              );
                            },
                            child: const Text('Check Answer'),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}