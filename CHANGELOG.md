## 0.9.0-samsung.5

* Fix: `initTerra` and `initConnection` now return the real success value from the native Android SDK instead of always returning `success: true`. Apps that branch on this flag will now see genuine initialisation and connection failures that were previously silent. The `error` field is unchanged. This brings Android in line with the behaviour iOS already implements.

## 0.9.0-samsung.4

* Bump android-sdk to 0.0.12 — fixes a crash on init when the user is linked to Samsung Health but the Samsung Health app is not installed (https://github.com/tryterra/TerraAndroidLocal/pull/26)

## 0.9.0-samsung.3

* Bump android-sdk (Samsung-direct) to 0.0.11 — fixes empty activity/sleep for already-granted users (https://github.com/tryterra/TerraAndroidLocal/pull/17)

## 0.6.3

* Bump TerraiOS SDK to 1.6.2 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.23 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 

## 0.6.2

* Bump TerraiOS SDK to 1.6.1 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.6.2-noperm

* Bump TerraiOS SDK to 1.6.1 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Android Health Connection No permissions included.

## 0.6.1

* Extend getAllPermissions function from Android Health Connect to Flutter.

## 0.6.0

* Bump TerraiOS SDK to 1.5.3 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.6.0-beta

* Bump TerraiOS SDK to 1.5.3-beta.3 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
    * This introduces WorkoutKit (PlannedWorkout) to Flutter

## 0.5.4

* Bump TerraiOS SDK to 1.5.2 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.21 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 

## 0.5.3

* Bump TerraiOS SDK to 1.5.1 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.5.2

* Bump TerraiOS SDK to 1.5.0 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.5.1

* Bump TerraiOS SDK to 1.4.8 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.4.8

* Bump TerraiOS SDK to 1.3.21 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.4.7

* Bump TerraiOS SDK to 1.3.19 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.14 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 


## 0.4.6

* Bump TerraiOS SDK to 1.3.16 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.4.5

* Bump TerraiOS SDK to 1.3.15 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.12 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 

## 0.4.4

* Bump TerraiOS SDK to 1.3.14 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.11 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 

## 0.4.3

* Bump TerraiOS SDK to 1.3.9 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.8 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 

## 0.4.2

* Bump TerraiOS SDK to 1.3.7 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.6 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 

## 0.4.1-nofsl.2

* Remove Freestylelibre scanning functionality from the SDK

## 0.4.1	

* Bump TerraiOS SDK to 1.3.5 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.5 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 

## 0.4.0	

* Bump TerraiOS SDK to 1.3.2 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.0 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)
* Includes Singleton update
* Can now receive data within getter functions (getActivity, getDaily etc.)

## 0.3.5	

* Bump TerraAndroid SDK to 1.3.8 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)
* Exposed Health Connect checker functions (isHealthConnectAvailable)

## 0.3.4	

* Bump TerraAndroid SDK to 1.3.5 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.3.3	

* Fixed a bug where activateSensor() and Swift Module handler had incorrect argument parsing

## 0.3.2	

* Bump TerraiOS SDK to 1.2.21 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.3.5 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.3.1	

* Bump TerraiOS SDK to 1.2.20 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.3.4 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.3.0	

* Update Android SDK to support Health Connect API

