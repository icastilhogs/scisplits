enum TimerStatus {
  none,
  running,
  paused,
  canceled,
  completed,
}

class SplitTimer {
  final int maxSeconds;
  final TimerStatus status;
  int seconds;
}
