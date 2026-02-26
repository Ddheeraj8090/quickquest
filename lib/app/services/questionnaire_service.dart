import '../models/questionnaire.dart';

class QuestionnaireService {
  List<Questionnaire> fetchQuestionnaires() {
    final commonQuestions = <Question>[
      const Question(
        id: 'q1',
        text: 'How often do you use mobile apps for learning?',
        options: ['Daily', 'Weekly', 'Monthly', 'Rarely'],
      ),
      const Question(
        id: 'q2',
        text: 'Which app feature matters most to you?',
        options: ['Speed', 'UI Design', 'Offline Access', 'Security'],
      ),
      const Question(
        id: 'q3',
        text: 'What time do you usually use productivity apps?',
        options: ['Morning', 'Afternoon', 'Evening', 'Late Night'],
      ),
      const Question(
        id: 'q4',
        text: 'How satisfied are you with your current digital habits?',
        options: ['Very Satisfied', 'Satisfied', 'Neutral', 'Not Satisfied'],
      ),
      const Question(
        id: 'q5',
        text: 'Would you recommend a questionnaire app to others?',
        options: ['Definitely', 'Maybe', 'Not Sure', 'No'],
      ),
    ];

    return [
      Questionnaire(
        id: 'quest_1',
        title: 'Digital Habit Check',
        description: 'Understand your app usage habits and routine.',
        questions: commonQuestions,
      ),
      Questionnaire(
        id: 'quest_2',
        title: 'Learning Preferences',
        description: 'Capture your preferred style for app-based learning.',
        questions: commonQuestions,
      ),
      Questionnaire(
        id: 'quest_3',
        title: 'Productivity Snapshot',
        description: 'Measure focus, consistency, and digital productivity.',
        questions: commonQuestions,
      ),
    ];
  }
}
