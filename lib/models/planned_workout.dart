import 'package:terra_flutter_bridge/models/enums.dart';

abstract class PlannedWorkoutSteps {
  Map<String, dynamic> toJson();
}

abstract class PlannedWorkoutStepDuration {
  Map<String, dynamic> toJson();
}

abstract class PlannedWorkoutStepTarget {
  Map<String, dynamic> toJson();
}

class TimePlannedWorkoutStepDuration extends PlannedWorkoutStepDuration {
  int durationType;
  int? seconds;

  TimePlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.time, this.seconds})
      : durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

	TimePlannedWorkoutStepDuration.fromValue({required this.durationType, this.seconds});


  factory TimePlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
    return TimePlannedWorkoutStepDuration.fromValue(
      durationType: json['duration_type'] as int,
      seconds: json['seconds'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'duration_type': durationType,
      'seconds': seconds,
    };
  }
}

class PowerAbovePlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{
		int durationType;
		double? powerAboveWatts;

		PowerAbovePlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.powerGreaterThan, this.powerAboveWatts})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		PowerAbovePlannedWorkoutStepDuration.fromValue({required this.durationType, this.powerAboveWatts});

    factory PowerAbovePlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
        return PowerAbovePlannedWorkoutStepDuration.fromValue(
            durationType: json['duration_type'] as int,
            powerAboveWatts: json['power_above_watts'] as double?,
        );
    }

    @override
    Map<String, dynamic> toJson() {
        return {
        'duration_type': durationType,
        'power_above_watts': powerAboveWatts,
        };
    }
}


class PowerBelowPlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{

    int durationType;
    double? powerBelowWatts;

		PowerBelowPlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.powerLessThan, this.powerBelowWatts})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		PowerBelowPlannedWorkoutStepDuration.fromValue({required this.durationType, this.powerBelowWatts});

		factory PowerBelowPlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
				return PowerBelowPlannedWorkoutStepDuration.fromValue(
						durationType: json['duration_type'] as int,
						powerBelowWatts: json['power_below_watts'] as double?,
				);
		}

    @override
		Map<String, dynamic> toJson() {
				return {
						'duration_type': durationType,
						'power_below_watts': powerBelowWatts,
				};
		}
}


class FixedRestPlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{
    int durationType;
    int? restSeconds;

		FixedRestPlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.fixedRest, this.restSeconds})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		FixedRestPlannedWorkoutStepDuration.fromValue({required this.durationType, this.restSeconds});

		factory FixedRestPlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
				return FixedRestPlannedWorkoutStepDuration.fromValue(
						durationType: json['duration_type'] as int,
						restSeconds: json['rest_seconds'] as int?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'duration_type': durationType,
            'rest_seconds': restSeconds,
        };
    }
}

class CaloriesPlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{
		int durationType;
    double? calories;

		CaloriesPlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.calories, this.calories})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		CaloriesPlannedWorkoutStepDuration.fromValue({required this.durationType, this.calories});

		factory CaloriesPlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
				return CaloriesPlannedWorkoutStepDuration.fromValue(
						durationType: json['duration_type'] as int,
						calories: json['calories'] as double?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'duration_type': durationType,
            'calories': calories,
        };
    }
}

class HRAbovePlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{
    int durationType;
    int? hrAboveBpm;

		HRAbovePlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.hrGreaterThan, this.hrAboveBpm})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		HRAbovePlannedWorkoutStepDuration.fromValue({required this.durationType, this.hrAboveBpm});

		factory HRAbovePlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
				return HRAbovePlannedWorkoutStepDuration.fromValue(
						durationType: json['duration_type'] as int,
						hrAboveBpm: json['hr_above_bpm'] as int?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'duration_type': durationType,
            'hr_above_bpm': hrAboveBpm,
        };
    }
}



class RepsPlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{

    int durationType;
    int? reps;

		RepsPlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.reps, this.reps})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		RepsPlannedWorkoutStepDuration.fromValue({required this.durationType, this.reps});

		factory RepsPlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
			return RepsPlannedWorkoutStepDuration.fromValue(
						durationType: json['duration_type'] as int,
						reps: json['reps'] as int?,
				);
		}


    @override
    Map<String, dynamic> toJson() {
        return {
            'duration_type': durationType,
            'reps': reps,
        };
    }
}

class HRBelowPlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{
    int durationType;
    int? hrBelowBpm;

		HRBelowPlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.hrLessThan, this.hrBelowBpm})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		HRBelowPlannedWorkoutStepDuration.fromValue({required this.durationType, this.hrBelowBpm});

		factory HRBelowPlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
				return HRBelowPlannedWorkoutStepDuration.fromValue(
						durationType: json['duration_type'] as int,
						hrBelowBpm: json['hr_below_bpm'] as int?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'duration_type': durationType,
            'hr_below_bpm': hrBelowBpm,
        };
    }
}

class DistancePlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{
    int durationType;
    double? distanceMeters;

		DistancePlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.distanceMeters, this.distanceMeters})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		DistancePlannedWorkoutStepDuration.fromValue({required this.durationType, this.distanceMeters});

		factory DistancePlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
				return DistancePlannedWorkoutStepDuration.fromValue(
						durationType: json['duration_type'] as int,
						distanceMeters: json['distance_meters'] as double?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'duration_type': durationType,
            'distance_meters': distanceMeters,
        };
    }
}

class StepsPlannedWorkoutStepDuration extends PlannedWorkoutStepDuration{
    int durationType;
    int? steps;

		StepsPlannedWorkoutStepDuration({PlannedWorkoutStepDurationType durationType = PlannedWorkoutStepDurationType.steps, this.steps})
				: durationType = getPlannedWorkoutStepDurationTypeValue(durationType);

		StepsPlannedWorkoutStepDuration.fromValue({required this.durationType, this.steps});

		factory StepsPlannedWorkoutStepDuration.fromJson(Map<String, dynamic> json) {
				return StepsPlannedWorkoutStepDuration.fromValue(
						durationType: json['duration_type'] as int,
						steps: json['steps'] as int?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'duration_type': durationType,
            'steps': steps,
        };
    }
}

// MARK: - Step Targets
class CadencePlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{
    int targetType;
    double? cadenceHigh;
    double? cadenceLow;
    double? cadence;

    CadencePlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.cadence, this.cadenceHigh, this.cadenceLow, this.cadence})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		CadencePlannedWorkoutStepTarget.fromValue({required this.targetType, this.cadenceHigh, this.cadenceLow, this.cadence});

		factory CadencePlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return CadencePlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						cadenceHigh: json['cadence_high'] as double?,
						cadenceLow: json['cadence_low'] as double?,
						cadence: json['cadence'] as double?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'target_type': targetType,
            'cadence_high': cadenceHigh,
            'cadence_low': cadenceLow,
            'cadence': cadence,
        };
    }
}

class HRPlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{
    int targetType;
    int? hrBpmHigh;
    int? hrBpmLow;
    double? hrPercentage;
    double? hrPercentageLow;
    double? hrPercentageHigh;

		HRPlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.heartRate, this.hrBpmHigh, this.hrBpmLow, this.hrPercentage, this.hrPercentageLow, this.hrPercentageHigh})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		HRPlannedWorkoutStepTarget.fromValue({required this.targetType, this.hrBpmHigh, this.hrBpmLow, this.hrPercentage, this.hrPercentageLow, this.hrPercentageHigh});

		factory HRPlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return HRPlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						hrBpmHigh: json['hr_bpm_high'] as int?,
						hrBpmLow: json['hr_bpm_low'] as int?,
						hrPercentage: json['hr_percentage'] as double?,
						hrPercentageLow: json['hr_percentage_low'] as double?,
						hrPercentageHigh: json['hr_percentage_high'] as double?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'target_type': targetType,
            'hr_bpm_high': hrBpmHigh,
            'hr_bpm_low': hrBpmLow,
            'hr_percentage': hrPercentage,
            'hr_percentage_low': hrPercentageLow,
            'hr_percentage_high': hrPercentageHigh,
        };
    }
}

class PowerPlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{
    int targetType;
    double? powerWattHigh;
    double? powerWattLow;
    double? powerWatt;
    double? powerPercentage;
    double? powerPercentageLow;
    double? powerPercentageHigh;

    PowerPlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.power, this.powerWattHigh, this.powerWattLow, this.powerWatt, this.powerPercentage, this.powerPercentageLow, this.powerPercentageHigh})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		PowerPlannedWorkoutStepTarget.fromValue({required this.targetType, this.powerWattHigh, this.powerWattLow, this.powerWatt, this.powerPercentage, this.powerPercentageLow, this.powerPercentageHigh});

		factory PowerPlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return PowerPlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						powerWattHigh: json['power_watt_high'] as double?,
						powerWattLow: json['power_watt_low'] as double?,
						powerWatt: json['power_watt'] as double?,
						powerPercentage: json['power_percentage'] as double?,
						powerPercentageLow: json['power_percentage_low'] as double?,
						powerPercentageHigh: json['power_percentage_high'] as double?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
      return {
          'target_type': targetType,
          'power_watt_high': powerWattHigh,
          'power_watt_low': powerWattLow,
          'power_watt': powerWatt,
          'power_percentage': powerPercentage,
          'power_percentage_low': powerPercentageLow,
          'power_percentage_high': powerPercentageHigh,
      };
  }
}

class SpeedPlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{
    int targetType;
    double? speedMetersPerSecond;
    double? speedPercentage;
    double? speedPercentageLow;
    double? speedPercentageHigh;

		SpeedPlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.speed, this.speedMetersPerSecond, this.speedPercentage, this.speedPercentageLow, this.speedPercentageHigh})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		SpeedPlannedWorkoutStepTarget.fromValue({required this.targetType, this.speedMetersPerSecond, this.speedPercentage, this.speedPercentageLow, this.speedPercentageHigh});

		factory SpeedPlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return SpeedPlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						speedMetersPerSecond: json['speed_meters_per_second'] as double?,
						speedPercentage: json['speed_percentage'] as double?,
						speedPercentageLow: json['speed_percentage_low'] as double?,
						speedPercentageHigh: json['speed_percentage_high'] as double?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'target_type': targetType,
            'speed_meters_per_second': speedMetersPerSecond,
            'speed_percentage': speedPercentage,
            'speed_percentage_low': speedPercentageLow,
            'speed_percentage_high': speedPercentageHigh,
        };
    }
}

class PacePlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{
    int targetType;
    double? paceMinutesPerKilometer;

		PacePlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.pace, this.paceMinutesPerKilometer})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		PacePlannedWorkoutStepTarget.fromValue({required this.targetType, this.paceMinutesPerKilometer});

		factory PacePlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return PacePlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						paceMinutesPerKilometer: json['pace_minutes_per_kilometer'] as double?,
				);
		}

    @override
		Map<String, dynamic> toJson() {
				return {
						'target_type': targetType,
						'pace_minutes_per_kilometer': paceMinutesPerKilometer,
				};
		}
}

class TSSPlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{
    int targetType;
    double? tss;

    TSSPlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.tss, this.tss})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		TSSPlannedWorkoutStepTarget.fromValue({required this.targetType, this.tss});

		factory TSSPlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return TSSPlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						tss: json['tss'] as double?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'target_type': targetType,
            'tss': tss,
        };
    }
}

class IFPlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{

    int targetType;
    double? ifHigh;
    double? ifLow;

    IFPlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.iF, this.ifHigh, this.ifLow})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		IFPlannedWorkoutStepTarget.fromValue({required this.targetType, this.ifHigh, this.ifLow});

		factory IFPlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return IFPlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						ifHigh: json['if_high'] as double?,
						ifLow: json['if_low'] as double?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'target_type': targetType,
            'if_high': ifHigh,
            'if_low': ifLow,
        };
    }
}

class RepetitionPlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{

    int targetType;
    int? repititions;

    RepetitionPlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.repetition, this.repititions})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		RepetitionPlannedWorkoutStepTarget.fromValue({required this.targetType, this.repititions});

		factory RepetitionPlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return RepetitionPlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						repititions: json['repititions'] as int?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'target_type': targetType,
            'repititions': repititions,
        };
    }
}

class SwimStrokePlannedWorkoutStepTarget extends PlannedWorkoutStepTarget{

    int targetType;
    int? swimStrokes;

    SwimStrokePlannedWorkoutStepTarget({PlannedWorkoutStepTargetType targetType = PlannedWorkoutStepTargetType.swimStroke, this.swimStrokes})
				: targetType = getPlannedWorkoutStepTargetTypeValue(targetType);

		SwimStrokePlannedWorkoutStepTarget.fromValue({required this.targetType, this.swimStrokes});

		factory SwimStrokePlannedWorkoutStepTarget.fromJson(Map<String, dynamic> json) {
				return SwimStrokePlannedWorkoutStepTarget.fromValue(
						targetType: json['target_type'] as int,
						swimStrokes: json['swim_strokes'] as int?,
				);
		}

    @override
    Map<String, dynamic> toJson() {
        return {
            'target_type': targetType,
            'swim_strokes': swimStrokes,
        };
    }
}
// MARK: - Planned Workout Step

class PlannedWorkoutStep extends PlannedWorkoutSteps {
    int? order;
    int type = 0;
    String? name;
    String? description;
    int? intensity;
    List<PlannedWorkoutStepDuration>? durations;
    List<PlannedWorkoutStepTarget>? targets;

    PlannedWorkoutStep({this.order, required this.type , this.name, this.description, this.intensity, this.durations, this.targets});

    PlannedWorkoutStep.fromJson(Map<String, dynamic> json) {
        order = json['order'] as int?;
        type = json['type'] as int;
        name = json['name'] as String?;
        description = json['description'] as String?;
        intensity = json['intensity'] as int?;
        if (json['durations'] != null) {
            durations = [];
            json['durations'].forEach((v) {
                durations!.add(TimePlannedWorkoutStepDuration.fromJson(v));
            });
        }
        if (json['targets'] != null) {
            targets = [];
            json['targets'].forEach((v) {
                targets!.add(CadencePlannedWorkoutStepTarget.fromJson(v));
            });
        }
    }
    @override
    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['order'] = order;
        data['type'] = type;
        data['name'] = name;
        data['description'] = description;
        data['intensity'] = intensity;
        if (durations != null) {
            data['durations'] = durations?.map((v) => v.toJson()).toList();
        }
        if (targets != null) {
            data['targets'] = targets?.map((v) => v.toJson()).toList();
        }
        return data;
    }
}


class PlannedWorkoutRepeatStep extends PlannedWorkoutSteps{
    int? order;
    int type = 1;
    String? name;
    String? description;
    int? intensity;
    List<PlannedWorkoutStepDuration>? durations;
    List<PlannedWorkoutStepTarget>? targets;
    List<PlannedWorkoutStep>? steps;
    
    PlannedWorkoutRepeatStep({this.order, required this.type, this.name, this.description, this.intensity, this.durations, this.targets, this.steps});

    PlannedWorkoutRepeatStep.fromJson(Map<String, dynamic> json){
        order = json['order'] as int?;
        type = json['type'] as int;
        name = json['name'] as String?;
        description = json['description'] as String?;
        intensity = json['intensity'] as int?;
        if (json['durations'] != null) {
            durations = [];
            json['durations'].forEach((v) {
                durations!.add(TimePlannedWorkoutStepDuration.fromJson(v));
            });
        }
        if (json['targets'] != null) {
            targets = [];
            json['targets'].forEach((v) {
                targets!.add(CadencePlannedWorkoutStepTarget.fromJson(v));
            });
        }
        if (json['steps'] != null) {
            steps = [];
            json['steps'].forEach((v) {
                steps!.add(PlannedWorkoutStep.fromJson(v));
            });
        }
    }

    @override
    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['order'] = order;
        data['type'] = type;
        data['name'] = name;
        data['description'] = description;
        data['intensity'] = intensity;
        if (durations != null) {
            data['durations'] = durations?.map((v) => v.toJson()).toList();
        }
        if (targets != null) {
            data['targets'] = targets?.map((v) => v.toJson()).toList();
        }
        if (steps != null) {
            data['steps'] = steps?.map((v) => v.toJson()).toList();
        }
        return data;
    }
}
// MARK: - Planned Workout

class PlannedWorkoutMetaData { 

    String id;
    String name;
    int type;
    String description;
    int? estimatedDurationSeconds;
    double? estimatedDistanceMeters;
    double? estimatedCalories;
    double? estimatedElevationGainMeters;
    double? estimatedEnergyKj;
    double? estimatedTss;
    double? estimatedIf;
    double? estimatedSpeedMetersPerSecond;
    double? estimatedTscore;
    double? estimatedPaceMinutesPerKilometer;
    String? provider;
    String? createdDate;
    String plannedDate;
    int? poolLengthMeters;

    PlannedWorkoutMetaData({required this.id, required this.name, required TerraActivityType type, required this.description, this.estimatedDurationSeconds, this.estimatedDistanceMeters, this.estimatedCalories, this.estimatedElevationGainMeters, this.estimatedEnergyKj, this.estimatedTss, this.estimatedIf, this.estimatedSpeedMetersPerSecond, this.estimatedTscore, this.estimatedPaceMinutesPerKilometer, this.provider, this.createdDate, required this.plannedDate, this.poolLengthMeters})
			: type = getTerraActivityTypeValue(type);

		PlannedWorkoutMetaData.fromJson(Map<String, dynamic> json) 
				: id = json['id'] as String,
				name = json['name'] as String,
				type = json['type'] as int,
				description = json['description'] as String,
				estimatedDurationSeconds = json['estimated_duration_seconds'] as int?,
				estimatedDistanceMeters = json['estimated_distance_meters'] as double?,
				estimatedCalories = json['estimated_calories'] as double?,
				estimatedElevationGainMeters = json['estimated_elevation_gain_meters'] as double?,
				estimatedEnergyKj = json['estimated_energy_kj'] as double?,
				estimatedTss = json['estimated_tss'] as double?,
				estimatedIf = json['estimated_if'] as double?,
				estimatedSpeedMetersPerSecond = json['estimated_speed_meters_per_second'] as double?,
				estimatedTscore = json['estimated_tscore'] as double?,
				estimatedPaceMinutesPerKilometer = json['estimated_pace_minutes_per_kilometer'] as double?,
				provider = json['provider'] as String?,
				createdDate = json['created_date'] as String?,
				plannedDate = json['planned_date'] as String,
				poolLengthMeters = json['pool_length_meters'] as int?;

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['id'] = id;
        data['name'] = name;
        data['type'] = type;
        data['description'] = description;
        data['estimated_duration_seconds'] = estimatedDurationSeconds;
        data['estimated_distance_meters'] = estimatedDistanceMeters;
        data['estimated_calories'] = estimatedCalories;
        data['estimated_elevation_gain_meters'] = estimatedElevationGainMeters;
        data['estimated_energy_kj'] = estimatedEnergyKj;
        data['estimated_tss'] = estimatedTss;
        data['estimated_if'] = estimatedIf;
        data['estimated_speed_meters_per_second'] = estimatedSpeedMetersPerSecond;
        data['estimated_tscore'] = estimatedTscore;
        data['estimated_pace_minutes_per_kilometer'] = estimatedPaceMinutesPerKilometer;
        data['provider'] = provider;
        data['created_date'] = createdDate;
        data['planned_date'] = plannedDate;
        data['pool_length_meters'] = poolLengthMeters;
        return data;
    }
}

class TerraPlannedWorkout {
    TerraPlannedWorkout({this.steps, this.metadata});

    List<PlannedWorkoutSteps>? steps;
    PlannedWorkoutMetaData? metadata;

    TerraPlannedWorkout.fromJson(Map<String, dynamic> json) {
        if (json['steps'] != null) {
            steps = [];
            json['steps'].forEach((v) {
                steps?.add(PlannedWorkoutStep.fromJson(v));
            });
        }
        metadata = json['metadata'] != null ? PlannedWorkoutMetaData.fromJson(json['metadata']) : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if (steps != null) {
            data['steps'] = steps?.map((v) => v.toJson()).toList();
        }
        if (metadata != null) {
            data['metadata'] = metadata?.toJson();
        }
        return data;
    }
}
