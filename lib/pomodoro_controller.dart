import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pomodoro/pomodoro_states_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pomodoro_controller.g.dart';

class PomodoroTimer {
  PomodoroState state;
  Duration duration;
  Timer? timer;

  PomodoroTimer(this.state, this.duration, this.timer);
}

@riverpod
class PomodoroController extends _$PomodoroController {
  @override
  PomodoroTimer build() {
    return PomodoroTimer(
      PomodoroState.work1,
      PomodoroState.work1.duration,
      null,
    );
  }

  startTimer() {
    Duration decrementTime = const Duration(seconds: 1);
    Duration interval = const Duration(seconds: 1);
    if (kDebugMode) {
      interval = const Duration(milliseconds: 10);
    }
    state.timer = Timer.periodic(
      interval,
      (timer) {
        if (state.duration.inSeconds == 0) {
          goNextState();
          return;
        }
        state = PomodoroTimer(
            state.state, state.duration - decrementTime, state.timer);
      },
    );
  }

  stopTimer() {
    state.timer?.cancel();
    state = PomodoroTimer(state.state, state.duration, null);
  }

  resetTimer() {
    stopTimer();
    state = PomodoroTimer(PomodoroState.work1, state.state.duration, null);
  }

  getIsPomodoroTimerActive() {
    if (state.timer == null) return false;
    return state.timer!.isActive;
  }

  goNextState() {
    stopTimer();
    state = PomodoroTimer(
      PomodoroState
          .values[(state.state.index + 1) % PomodoroState.values.length],
      PomodoroState
          .values[(state.state.index + 1) % PomodoroState.values.length]
          .duration,
      null,
    );
  }

  get duration => state.duration;
}
