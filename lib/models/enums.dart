enum PlannedWorkoutStepDurationType {
  time,
  distanceMeters,
  hrLessThan,
  hrGreaterThan,
  calories,
  open,
  powerLessThan,
  powerGreaterThan,
  repetitionTime,
  reps,
  fixedRest,
  timeAtValidCda,
  steps,
}

enum PlannedWorkoutStepTargetType {
  speed,
  heartRate,
  open,
  cadence,
  power,
  grade,
  resistance,
  powerLap,
  swimStroke,
  speedLap,
  heartRateLap,
  pace,
  heartRateThresholdPercentage,
  heartRateMaxPercentage,
  speedPercentage,
  powerPercentage,
  repetition,
  tss,
  iF,
}

enum TerraActivityType {
  inVehicle,
  biking,
  still,
  unknown,
  tilting,
  walking,
  running,
  aerobics,
  badminton,
  baseball,
  basketball,
  biathlon,
  handbiking,
  mountainBiking,
  roadBiking,
  spinning,
  stationaryBiking,
  utilityBiking,
  boxing,
  calisthenics,
  circuitTraining,
  cricket,
  dancing,
  elliptical,
  fencing,
  americanFootball,
  australianFootball,
  englishFootball,
  frisbee,
  gardening,
  golf,
  gymnastics,
  handball,
  hiking,
  hockey,
  horsebackRiding,
  housework,
  jumpingRope,
  kayaking,
  kettlebellTraining,
  kickboxing,
  kitesurfing,
  martialArts,
  meditation,
  mixedMartialArts,
  p90xExercises,
  paragliding,
  pilates,
  polo,
  racquetball,
  rockClimbing,
  rowing,
  rowingMachine,
  rugby,
  jogging,
  runningOnSand,
  treadmillRunning,
  sailing,
  scubaDiving,
  skateboarding,
  skating,
  crossSkating,
  indoorRollerblading,
  skiing,
  backCountrySkiing,
  crossCountrySkiing,
  downhillSkiing,
  kiteSkiing,
  rollerSkiing,
  sledding,
  snowboarding,
  snowmobile,
  snowshoeing,
  squash,
  stairClimbing,
  stairClimbingMachine,
  standUpPaddleboarding,
  strengthTraining,
  surfing,
  swimming,
  swimmingSwimmingPool,
  swimmingOpenWater,
  tableTennis,
  teamSports,
  tennis,
  treadmill,
  volleyball,
  volleyballBeach,
  volleyballIndoor,
  wakeboarding,
  walkingFitness,
  nordicWalking,
  walkingTreadmill,
  waterpolo,
  weightlifting,
  wheelchair,
  windsurfing,
  yoga,
  zumba,
  diving,
  ergometer,
  iceSkating,
  indoorSkating,
  curling,
  other,
  crossfit,
  hiit,
  intervalTraining,
  walkingStroller,
  elevator,
  escalator,
  archery,
  softball,
  guidedBreathing,
  cardioTraining,
  lacrosse,
  stretching,
  triathlon,
  inlineSkating,
  skyDiving,
  paddling,
  mountaineering,
  fishing,
  waterSkiing,
  indoorRunning,
  padelTennis,
}

enum CustomPermission {
  workoutTypes,
  activitySummary,
  location,
  calories,
  steps,
  heartRate,
  heartRateVariability,
  vo2max,
  height,
  activeDurations,
  weight,
  flightsClimbed,
  bmi,
  bodyFat,
  exerciseDistance,
  gender,
  dateOfBirth,
  basalEnergyBurned,
  swimmingSummary,
  restingHeartRate,
  bloodPressure,
  bloodGlucose,
  bodyTemperature,
  leanBodyMass,
  oxygenSaturation,
  sleepAnalysis,
  respiratoryRate,
  nutritionSodium,
  nutritionProtein,
  nutritionCarbohydrates,
  nutritionFibre,
  nutritionFatTotal,
  nutritionSugar,
  nutritionVitaminC,
  nutritionVitaminA,
  nutritionCalories,
  nutritionWater,
  nutritionCholesterol,
  menstruation,
  speed,
  power,
  electrocardiogram,
}

enum Connection {
  appleHealth,
  googleFit,
  samsung,
  freestyleLibre,
  healthConnect,
}

extension ConnectionExtension on Connection {
  String get connectionString {
    switch (this) {
      case Connection.appleHealth:
        return 'APPLE_HEALTH';
      case Connection.googleFit:
        return 'GOOGLE';
      case Connection.samsung:
        return 'SAMSUNG';
      case Connection.freestyleLibre:
        return 'FREESTYLE_LIBRE';
      case Connection.healthConnect:
        return 'HEALTH_CONNECT';
      default:
        return 'UNDEFINED';
    }
  }
}

extension CustomPermissionExtension on CustomPermission {
  String get customPermissionString {
    switch (this) {
      case CustomPermission.workoutTypes:
        return 'WORKOUT_TYPES';
      case CustomPermission.activitySummary:
        return 'ACTIVITY_SUMMARY';
      case CustomPermission.location:
        return 'LOCATION';
      case CustomPermission.calories:
        return 'CALORIES';
      case CustomPermission.steps:
        return 'STEPS';
      case CustomPermission.heartRate:
        return 'HEART_RATE';
      case CustomPermission.heartRateVariability:
        return 'HEART_RATE_VARIABILITY';
      case CustomPermission.vo2max:
        return 'VO2MAX';
      case CustomPermission.height:
        return 'HEIGHT';
      case CustomPermission.activeDurations:
        return 'ACTIVE_DURATIONS';
      case CustomPermission.weight:
        return 'WEIGHT';
      case CustomPermission.flightsClimbed:
        return 'FLIGHTS_CLIMBED';
      case CustomPermission.bmi:
        return 'BMI';
      case CustomPermission.bodyFat:
        return 'BODY_FAT';
      case CustomPermission.exerciseDistance:
        return 'EXERCISE_DISTANCE';
      case CustomPermission.gender:
        return 'GENDER';
      case CustomPermission.dateOfBirth:
        return 'DATE_OF_BIRTH';
      case CustomPermission.basalEnergyBurned:
        return 'BASAL_ENERGY_BURNED';
      case CustomPermission.swimmingSummary:
        return 'SWIMMING_SUMMARY';
      case CustomPermission.restingHeartRate:
        return 'RESTING_HEART_RATE';
      case CustomPermission.bloodPressure:
        return 'BLOOD_PRESSURE';
      case CustomPermission.bloodGlucose:
        return 'BLOOD_GLUCOSE';
      case CustomPermission.bodyTemperature:
        return 'BODY_TEMPERATURE';
      case CustomPermission.leanBodyMass:
        return 'LEAN_BODY_MASS';
      case CustomPermission.oxygenSaturation:
        return 'OXYGEN_SATURATION';
      case CustomPermission.sleepAnalysis:
        return 'SLEEP_ANALYSIS';
      case CustomPermission.respiratoryRate:
        return 'RESPIRATORY_RATE';
      case CustomPermission.nutritionSodium:
        return 'NUTRITION_SODIUM';
      case CustomPermission.nutritionProtein:
        return 'NUTRITION_PROTEIN';
      case CustomPermission.nutritionCarbohydrates:
        return 'NUTRITION_CARBOHYDRATES';
      case CustomPermission.nutritionFibre:
        return 'NUTRITION_FIBRE';
      case CustomPermission.nutritionFatTotal:
        return 'NUTRITION_FAT_TOTAL';
      case CustomPermission.nutritionSugar:
        return 'NUTRITION_SUGAR';
      case CustomPermission.nutritionVitaminC:
        return 'NUTRITION_VITAMIN_C';
      case CustomPermission.nutritionVitaminA:
        return 'NUTRITION_VITAMIN_A';
      case CustomPermission.nutritionCalories:
        return 'NUTRITION_CALORIES';
      case CustomPermission.nutritionWater:
        return 'NUTRITION_WATER';
      case CustomPermission.nutritionCholesterol:
        return 'NUTRITION_CHOLESTEROL';
      case CustomPermission.menstruation:
        return 'MENSTRUATION';
      case CustomPermission.speed:
        return "SPEED";
      case CustomPermission.power:
        return "POWER";
      case CustomPermission.electrocardiogram:
        return "ELECTROCARDIOGRAM";
      default:
        return 'UNDEFINED';
    }
  }
}

int getPlannedWorkoutStepTargetTypeValue(PlannedWorkoutStepTargetType type) {
  return PlannedWorkoutStepTargetType.values.indexOf(type);
}

int getPlannedWorkoutStepDurationTypeValue(PlannedWorkoutStepDurationType type) {
  return PlannedWorkoutStepDurationType.values.indexOf(type);
}

int getTerraActivityTypeValue(TerraActivityType type) {
  switch (type){
    case TerraActivityType.inVehicle:
      return 0;
    case TerraActivityType.biking:
      return 1;
    case TerraActivityType.still:
      return 3;
    case TerraActivityType.unknown:
      return 4;
    case TerraActivityType.tilting:
      return 5;
    case TerraActivityType.walking:
      return 7;
    case TerraActivityType.running:
      return 8;
    case TerraActivityType.aerobics:
      return 9;
    case TerraActivityType.badminton:
      return 10;
    case TerraActivityType.baseball:
      return 11;
    case TerraActivityType.basketball:
      return 12;
    case TerraActivityType.biathlon:
      return 13;
    case TerraActivityType.handbiking:
      return 14;
    case TerraActivityType.mountainBiking:
      return 15;
    case TerraActivityType.roadBiking:
      return 16;
    case TerraActivityType.spinning:
      return 17;
    case TerraActivityType.stationaryBiking:
      return 18;
    case TerraActivityType.utilityBiking:
      return 19;
    case TerraActivityType.boxing:
      return 20;
    case TerraActivityType.calisthenics:
      return 21;
    case TerraActivityType.circuitTraining:
      return 22;
    case TerraActivityType.cricket:
      return 23;
    case TerraActivityType.dancing:
      return 24;
    case TerraActivityType.elliptical:
      return 25;
    case TerraActivityType.fencing:
      return 26;
    case TerraActivityType.americanFootball:
      return 27;
    case TerraActivityType.australianFootball:
      return 28;
    case TerraActivityType.englishFootball:
      return 29;
    case TerraActivityType.frisbee:
      return 30;
    case TerraActivityType.gardening:
      return 31;
    case TerraActivityType.golf:
      return 32;
    case TerraActivityType.gymnastics:
      return 33;
    case TerraActivityType.handball:
      return 34;
    case TerraActivityType.hiking:
      return 35;
    case TerraActivityType.hockey:
      return 36;
    case TerraActivityType.horsebackRiding:
      return 37;
    case TerraActivityType.housework:
      return 38;
    case TerraActivityType.jumpingRope:
      return 39;
    case TerraActivityType.kayaking:
      return 40;
    case TerraActivityType.kettlebellTraining:
      return 41;
    case TerraActivityType.kickboxing:
      return 42;
    case TerraActivityType.kitesurfing:
      return 43;
    case TerraActivityType.martialArts:
      return 44;
    case TerraActivityType.meditation:
      return 45;
    case TerraActivityType.mixedMartialArts:
      return 46;
    case TerraActivityType.p90xExercises:
      return 47;
    case TerraActivityType.paragliding:
      return 48;
    case TerraActivityType.pilates:
      return 49;
    case TerraActivityType.polo:
      return 50;
    case TerraActivityType.racquetball:
      return 51;
    case TerraActivityType.rockClimbing:
      return 52;
    case TerraActivityType.rowing:
      return 53;
    case TerraActivityType.rowingMachine:
      return 54;
    case TerraActivityType.rugby:
      return 55;
    case TerraActivityType.jogging:
      return 56;
    case TerraActivityType.runningOnSand:
      return 57;
    case TerraActivityType.treadmillRunning:
      return 58;
    case TerraActivityType.sailing:
      return 59;
    case TerraActivityType.scubaDiving:
      return 60;
    case TerraActivityType.skateboarding:
      return 61;
    case TerraActivityType.skating:
      return 62;
    case TerraActivityType.crossSkating:
      return 63;
    case TerraActivityType.indoorRollerblading:
      return 64;
    case TerraActivityType.skiing:
      return 65;
    case TerraActivityType.backCountrySkiing:
      return 66;
    case TerraActivityType.crossCountrySkiing:
      return 67;
    case TerraActivityType.downhillSkiing:
      return 68;
    case TerraActivityType.kiteSkiing:
      return 69;
    case TerraActivityType.rollerSkiing:
      return 70;
    case TerraActivityType.sledding:
      return 71;
    case TerraActivityType.snowboarding:
      return 73;
    case TerraActivityType.snowmobile:
      return 74;
    case TerraActivityType.snowshoeing:
      return 75;
    case TerraActivityType.squash:
      return 76;
    case TerraActivityType.stairClimbing:
      return 77;
    case TerraActivityType.stairClimbingMachine:
      return 78;
    case TerraActivityType.standUpPaddleboarding:
      return 79;
    case TerraActivityType.strengthTraining:
      return 80;
    case TerraActivityType.surfing:
      return 81;
    case TerraActivityType.swimming:
      return 82;
    case TerraActivityType.swimmingSwimmingPool:
      return 83;
    case TerraActivityType.swimmingOpenWater:
      return 84;
    case TerraActivityType.tableTennis:
      return 85;
    case TerraActivityType.teamSports:
      return 86;
    case TerraActivityType.tennis:
      return 87;
    case TerraActivityType.treadmill:
      return 88;
    case TerraActivityType.volleyball:
      return 89;
    case TerraActivityType.volleyballBeach:
      return 90;
    case TerraActivityType.volleyballIndoor:
      return 91;
    case TerraActivityType.wakeboarding:
      return 92;
    case TerraActivityType.walkingFitness:
      return 93;
    case TerraActivityType.nordicWalking:
      return 94;
    case TerraActivityType.walkingTreadmill:
      return 95;
    case TerraActivityType.waterpolo:
      return 96;
    case TerraActivityType.weightlifting:
      return 97;
    case TerraActivityType.wheelchair:
      return 98;
    case TerraActivityType.windsurfing:
      return 99;
    case TerraActivityType.yoga:
      return 100;
    case TerraActivityType.zumba:
      return 101;
    case TerraActivityType.diving:
      return 102;
    case TerraActivityType.ergometer:
      return 103;
    case TerraActivityType.iceSkating:
      return 104;
    case TerraActivityType.indoorSkating:
      return 105;
    case TerraActivityType.curling:
      return 106;
    case TerraActivityType.other:
      return 108;
    case TerraActivityType.crossfit:
      return 113;
    case TerraActivityType.hiit:
      return 114;
    case TerraActivityType.intervalTraining:
      return 115;
    case TerraActivityType.walkingStroller:
      return 116;
    case TerraActivityType.elevator:
      return 117;
    case TerraActivityType.escalator:
      return 118;
    case TerraActivityType.archery:
      return 119;
    case TerraActivityType.softball:
      return 120;
    case TerraActivityType.guidedBreathing:
      return 122;
    case TerraActivityType.cardioTraining:
      return 123;
    case TerraActivityType.lacrosse:
      return 124;
    case TerraActivityType.stretching:
      return 125;
    case TerraActivityType.triathlon:
      return 126;
    case TerraActivityType.inlineSkating:
      return 127;
    case TerraActivityType.skyDiving:
      return 128;
    case TerraActivityType.paddling:
      return 129;
    case TerraActivityType.mountaineering:
      return 130;
    case TerraActivityType.fishing:
      return 131;
    case TerraActivityType.waterSkiing:
      return 132;
    case TerraActivityType.indoorRunning:
      return 133;
    case TerraActivityType.padelTennis:
      return 134;
  }
}
