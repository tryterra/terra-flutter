import 'dart:math';
import 'package:terra_flutter_bridge/models/enums.dart';
import 'package:terra_flutter_bridge/models/planned_workout.dart';

TerraPlannedWorkout generateSamplePlannedWorkout() {
  final metadata = PlannedWorkoutMetaData(
    id: "ceef601a-23e4-4393-8483-a9f6d37b0407",
    name: "My Workout",
    description: "This is a sample workout",
    type: TerraActivityType.running,
    plannedDate: "2024-01-31T15:00:00+00:00",
    createdDate: "2024-01-31T15:00:00+00:00",
  );

  return TerraPlannedWorkout(
    steps: generatePlannedWorkoutSteps(),
    metadata: metadata,
  );
}

List<PlannedWorkoutStepDuration> generatePlannedWorkoutStepDurations() {
  var steps = <PlannedWorkoutStepDuration>[];
  var random = Random();
  for (var i = 0; i < 1; i++) {
    steps.add(RepsPlannedWorkoutStepDuration(reps: random.nextInt(10) + 1));
  }
  return steps;
}

PlannedWorkoutStep generatePlannedWorkoutStep(int order) {
  return PlannedWorkoutStep(
    type: 0,
    order: order,
    durations: generatePlannedWorkoutStepDurations(),
    targets: [HRPlannedWorkoutStepTarget(
      hrBpmHigh: 170
    )],
  );
}

PlannedWorkoutRepeatStep generatePlannedWorkoutRepeatStep() {
  return PlannedWorkoutRepeatStep(
    type: 1,
    order: 0,
    durations: generatePlannedWorkoutStepDurations(),
    targets: [HRPlannedWorkoutStepTarget(
      hrBpmHigh: 170
    )],
    steps: [generatePlannedWorkoutStep(1)],
  );
}

List<PlannedWorkoutSteps> generatePlannedWorkoutSteps() {
  var steps = <PlannedWorkoutSteps>[];
  for (var i = 0; i < 1; i++) {
    steps.add(
      generatePlannedWorkoutStep(i),
    );
  }
  steps.add(generatePlannedWorkoutRepeatStep());
  return steps;
}
