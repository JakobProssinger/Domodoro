enum PomodoroState {
  work1,
  shorBreak,
  work2,
  longBreak,
}

extension StateDuration on PomodoroState {
  Duration get duration {
    switch (this) {
      case PomodoroState.work1:
      case PomodoroState.work2:
        return const Duration(minutes: 25);
      case PomodoroState.shorBreak:
        return const Duration(minutes: 5);
      case PomodoroState.longBreak:
        return const Duration(minutes: 15);
      default:
        return const Duration(minutes: 25);
    }
  }
}
