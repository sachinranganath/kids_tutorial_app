import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String subject;

  const QuizPage({super.key, required this.subject});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Color lightBlue = const Color.fromARGB(255, 202, 233, 244);

  int currentQuestion = 0;
  bool answered = false;
  int score = 0;

  late List<Map<String, Object>> questions;

  @override
  void initState() {
    super.initState();

    if (widget.subject.toLowerCase() == "english") {
      questions = [
        {
          "question": "Which word is a fruit?",
          "options": ["Cat", "Apple", "Table", "Book"],
          "answer": "Apple",
        },
        {
          "question": "Which is the correct spelling?",
          "options": ["Beutiful", "Beautiful", "Beautifull", "Bautiful"],
          "answer": "Beautiful",
        },
        {
          "question": "Opposite of 'Cold' is?",
          "options": ["Hot", "Cool", "Freeze", "Chill"],
          "answer": "Hot",
        },
        {
          "question": "Which word rhymes with 'Ball'?",
          "options": ["Cat", "Wall", "Run", "Dog"],
          "answer": "Wall",
        },
        {
          "question": "Which one is a noun?",
          "options": ["Run", "Happy", "Chair", "Quickly"],
          "answer": "Chair",
        },
      ];
    } else if (widget.subject.toLowerCase() == "math") {
      questions = [
        {
          "question": "2 + 3 = ?",
          "options": ["4", "5", "6", "3"],
          "answer": "5",
        },
        {
          "question": "What comes after 7?",
          "options": ["6", "8", "9", "10"],
          "answer": "8",
        },
        {
          "question": "10 - 6 = ?",
          "options": ["3", "5", "4", "6"],
          "answer": "4",
        },
        {
          "question": "What is half of 10?",
          "options": ["4", "5", "6", "3"],
          "answer": "5",
        },
        {
          "question": "How many sides does a triangle have?",
          "options": ["2", "3", "4", "5"],
          "answer": "3",
        },
      ];
    } else if (widget.subject.toLowerCase() == "arts & craft" ||
        widget.subject.toLowerCase() == "arts and craft" ||
        widget.subject.toLowerCase() == "arts" ||
        widget.subject.toLowerCase() == "arts & crafts") {
      questions = [
        {
          "question": "What color do you get when you mix red and yellow?",
          "options": ["Green", "Orange", "Purple", "Pink"],
          "answer": "Orange",
        },
        {
          "question": "Which tool is used to cut paper?",
          "options": ["Pencil", "Brush", "Scissors", "Eraser"],
          "answer": "Scissors",
        },
        {
          "question": "What is used to stick two papers together?",
          "options": ["Glue", "Paint", "Tape", "Stapler"],
          "answer": "Glue",
        },
        {
          "question": "Which of these is a warm color?",
          "options": ["Blue", "Green", "Yellow", "Purple"],
          "answer": "Yellow",
        },
        {
          "question": "What do we use to paint?",
          "options": ["Brush", "Scissors", "Glue", "Eraser"],
          "answer": "Brush",
        },
      ];
    } else {
      questions = [
        {
          "question": "Flutter is developed by?",
          "options": ["Apple", "Google", "Microsoft", "Amazon"],
          "answer": "Google",
        },
      ];
    }
  }

  void checkAnswer(String selected) {
    if (answered) return;
    setState(() {
      answered = true;
      questions[currentQuestion]["selected"] = selected;
      if (selected == questions[currentQuestion]["answer"]) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        answered = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("🎉 Quiz Completed!"),
          content: Text("You scored $score / ${questions.length}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final options = question["options"] as List<String>;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("${widget.subject} Quiz"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/splash.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Question ${currentQuestion + 1}/${questions.length}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      question["question"] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ...options.map((option) {
                      final isSelected =
                          question["selected"] != null &&
                          question["selected"] == option;
                      final isCorrect =
                          option == question["answer"] && answered;
                      final isWrong =
                          isSelected && option != question["answer"];

                      Color btnColor = Colors.white;
                      if (answered) {
                        if (isCorrect) btnColor = Colors.green.shade300;
                        if (isWrong) btnColor = Colors.red.shade300;
                      }

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: btnColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            option,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: answered ? nextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightBlue,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        currentQuestion == questions.length - 1
                            ? "Finish"
                            : "Next",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
