import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/counter.dart';
import 'models/global_timer.dart';
import 'models/images.dart';
import 'models/routine.dart';

final imageProvider = StateNotifierProvider<Images, String>(
  (ref) {
    return Images(ref: ref);
  },
);

final timerProvider = ChangeNotifierProvider<GlobalTimerNotifier>(((ref) {
  return GlobalTimerNotifier(ref: ref);
}));

final counterProvider = StateNotifierProvider<Counter, int>(((ref) {
  return Counter(ref: ref);
}));

final routineProvider = Provider(((ref) {
  //final counter = ref.read(counterProvider.notifier);
  //final timer =
  return Routine(
    ref: ref,
    name: 'Lean Front Splits',
    description:
        'Exercise curation based on 32 scientific articles. Only the most effective with the right tecnique.',
  );
}));
