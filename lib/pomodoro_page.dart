import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/pomodoro_controller.dart';

class PomodoroPage extends ConsumerStatefulWidget {
  const PomodoroPage({super.key});

  @override
  ConsumerState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends ConsumerState<PomodoroPage> {
  formatDuration(Duration d) {
    String minutes = d.inMinutes.toString().padLeft(2, '0');
    String seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  timerIsActive(PomodoroTimer state) {
    if (state.timer == null) return false;
    return state.timer!.isActive;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final controller = ref.watch(pomodoroControllerProvider.notifier);
    final pomodoroState = ref.watch(pomodoroControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pomodoro',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              formatDuration(pomodoroState.duration),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    controller.resetTimer();
                  },
                  icon: const Icon(Icons.lock_reset),
                  label: const Text(
                    'Reset',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    bool isActive = timerIsActive(pomodoroState);
                    if (isActive) {
                      controller.stopTimer();
                    } else {
                      controller.startTimer();
                    }
                  },
                  icon: controller.getIsPomodoroTimerActive()
                      ? const Icon(Icons.pause)
                      : const Icon(
                          Icons.play_arrow,
                        ),
                  label: const Text(
                    'Start',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.goNextState();
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  label: const Text(
                    'skipp',
                  ),
                ),
              ],
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PomodoroProgress extends StatelessWidget {
  const PomodoroProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
