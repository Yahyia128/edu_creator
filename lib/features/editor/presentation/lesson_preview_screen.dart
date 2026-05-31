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

          // TEXT BLOCK
          if (block['type'] == 'text') {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Text(block['text'] ?? '', style: const TextStyle(fontSize: 18)),
            );
          }

          // IMAGE BLOCK
          if (block['type'] == 'image') {
            if (block['imageBase64'] == null) return const SizedBox();
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
                  const Text('Quiz', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...List.generate(block['questions'].length, (questionIndex) {
                    final question = block['questions'][questionIndex];
                    final answerKey = '${index}_$questionIndex';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(question['question'] ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),

                          // MULTIPLE CHOICE
                          if ((question['type'] ?? 'multiple_choice') == 'multiple_choice')
                            ...List.generate(question['options']?.length ?? 0, (optionIndex) {
                              final optionText = question['options'][optionIndex] ?? '';
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

                          // TRUE FALSE
                          if (question['type'] == 'true_false')
                            Column(
                              children: [
                                RadioListTile<bool>(
                                  value: true,
                                  groupValue: selectedAnswers[answerKey] ?? false,
                                  title: const Text('True'),
                                  onChanged: (value) => setState(() => selectedAnswers[answerKey] = value),
                                ),
                                RadioListTile<bool>(
                                  value: false,
                                  groupValue: selectedAnswers[answerKey] ?? false,
                                  title: const Text('False'),
                                  onChanged: (value) => setState(() => selectedAnswers[answerKey] = value),
                                ),
                              ],
                            ),

                          // WRITTEN
                          if (question['type'] == 'written')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Written Answer:', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                TextField(
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    hintText: 'Write your answer here...',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (value) => selectedAnswers[answerKey] = value,
                                ),
                              ],
                            ),

                          const SizedBox(height: 12),

                          // CHECK ANSWER BUTTON
                          ElevatedButton(
                            onPressed: () {
                              final userAnswer = selectedAnswers[answerKey];
                              final correctAnswer = question['correctAnswer'];

                              if (correctAnswer == null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Error'),
                                    content: Text('No correct answer for: ${question['question']}'),
                                  ),
                                );
                                return;
                              }

                              bool isCorrect = false;
                              String displayAnswer = correctAnswer.toString();

                              if ((question['type'] ?? 'multiple_choice') == 'multiple_choice') {
                                isCorrect = userAnswer == correctAnswer;
                                displayAnswer = question['options']?[correctAnswer] ?? correctAnswer.toString();
                              } else if (question['type'] == 'true_false') {
                                isCorrect = userAnswer == correctAnswer;
                                displayAnswer = correctAnswer ? 'True' : 'False';
                              } else if (question['type'] == 'written') {
                                isCorrect = userAnswer?.toString().trim().toLowerCase() == correctAnswer.toString().trim().toLowerCase();
                              }

                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(isCorrect ? '✓ Correct!' : '✗ Wrong'),
                                  content: Text(isCorrect ? 'Good Job!' : 'Correct Answer: $displayAnswer'),
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