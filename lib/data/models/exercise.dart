import 'package:scisplits/data/models/muscle.dart';

enum Side {
  right('Right'),
  left('Left');

  final String name;
  const Side(this.name);
}

enum Exercises {
  sideLunge(
    name: 'Side lunge',
    description: '',
    muscles: [MuscleGroup.flexors],
  ),
  forwardLunge(
    name: 'Forward lunge',
    description: '',
    muscles: [MuscleGroup.flexors],
  ),
  standingHamstring(
    name: 'Standing hamstring',
    description: '',
    muscles: [MuscleGroup.hamstrings],
  ),
  frontSplits(
    name: 'Front splits',
    description: '',
    muscles: [
      MuscleGroup.hamstrings,
      MuscleGroup.adductors,
      MuscleGroup.flexors,
      MuscleGroup.gluteal,
      MuscleGroup.quadriceps
    ],
  ),
  middleSplits(
    name: 'Middle splits',
    description: '',
    muscles: [MuscleGroup.adductors, MuscleGroup.flexors],
    hasSides: false,
  );

  final List<MuscleGroup> muscles;
  final String name;
  final String description;
  final bool hasSides;

  const Exercises({
    required this.muscles,
    required this.name,
    required this.description,
    this.hasSides = true,
  });
}

class Exercise {
  Exercise({
    required this.type,
    //required this.name,
    this.id = 'generic',
    this.hasSides = true,
    this.side = Side.right,
    this.duration = 60,
    //this.isCompleted = false,
    this.totalSets = 3,
    this.set = 1,
  });

  Exercise copyWith({
    required String id,
    Side? newLeg,
    int? newCurrentRep,
    bool? newIsCompleted,
  }) {
    return Exercise(
      id: id,
      type: type,
      hasSides: hasSides,
      duration: duration,
      //name: name,
      totalSets: totalSets,
      side: newLeg ?? side,
      set: newCurrentRep ?? set,
    );
  }

  final String id;
  final bool hasSides;
  final Side side;
  final int duration;

  final int totalSets;
  final Exercises type;
  final int set;

  Map<MuscleGroup, Side> get targetMuscles {
    //final List<Map<Muscle, Side>> result = [];
    return {for (MuscleGroup muscle in type.muscles) muscle: side};
  }

  String get name => type.name;

  String get status => '${Side.left.name} leg ${set}x$totalSets';
}
