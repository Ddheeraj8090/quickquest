class Question {
  const Question({
    required this.id,
    required this.text,
    required this.options,
  });

  final String id;
  final String text;
  final List<String> options;
}

class Questionnaire {
  const Questionnaire({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  final String id;
  final String title;
  final String description;
  final List<Question> questions;
}
