import 'exercise.dart';

class UserProgress {
  UserProgress({this.sessions});
  final List<Session>? sessions;
}

class Session {
  Session({
    required this.completed,
    required this.elapsedTime,
    required this.timestamp,
    required this.duration,
  });
  final List<Exercise> completed;
  final Duration elapsedTime;
  final DateTime timestamp;
  final Duration duration;
}
