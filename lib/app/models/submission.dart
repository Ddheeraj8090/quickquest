class Submission {
  const Submission({
    required this.questionnaireId,
    required this.questionnaireTitle,
    required this.answers,
    required this.submittedAt,
    required this.latitude,
    required this.longitude,
  });

  final String questionnaireId;
  final String questionnaireTitle;
  final Map<String, int> answers;
  final DateTime submittedAt;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toMap() {
    return {
      'questionnaireId': questionnaireId,
      'questionnaireTitle': questionnaireTitle,
      'answers': answers.map((k, v) => MapEntry(k, v)),
      'submittedAt': submittedAt.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Submission.fromMap(Map<dynamic, dynamic> map) {
    return Submission(
      questionnaireId: map['questionnaireId'] as String? ?? '',
      questionnaireTitle: map['questionnaireTitle'] as String? ?? '',
      answers:
          (map['answers'] as Map<dynamic, dynamic>? ?? {}).map(
            (key, value) => MapEntry(key.toString(), value as int),
          ),
      submittedAt:
          DateTime.tryParse(map['submittedAt'] as String? ?? '') ??
          DateTime.now(),
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0,
    );
  }
}
