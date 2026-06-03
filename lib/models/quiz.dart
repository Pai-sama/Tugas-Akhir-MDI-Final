class QuizQuestion {
  final String id;
  final String question;
  final String imagePath;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.imagePath,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}
