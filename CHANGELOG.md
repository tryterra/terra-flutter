## 0.11.0
* Bump TerraiOS SDK to ~> 1.9.1 (from ~> 1.7.10) — **upgrade recommended for all iOS users.**
    - Fixes background Apple Health data being lost permanently. A background wake that could not
      publish (device locked, or the upload failed) still drained the pending cache and advanced the
      HealthKit anchors, so the skipped samples were discarded and never re-read — the device went
      silent and stayed silent. Reads are now deferred and replayed on unlock, and the caches and
      anchors are only retired once the data is actually on the wire (ZD 6317).
    - Guards a crash on HealthKit unit conversion for BMI and other body quantities.
    - `initTerra` on iOS can now return `success: false` with an `error` for Apple Health.
      HealthKit authorisation failures previously never reached the caller, so this path never fired.
    - Apple Health init no longer hangs forever if HealthKit never calls back; it times out after 60s
      and reports a failure.
    - Adds the `healthObservation` data type (raw HealthKit sample push). Requested only when the
      scope is enabled for your developer account, so no new HealthKit prompt for existing apps.
    - Daily samples that cross midnight are attributed to the day they start.

## 0.10.1
* Android: fix a `NullPointerException` in `onDetachedFromEngine` when the plugin runs on a headless
  Flutter engine that never attaches an Activity, such as an FCM background isolate. The method
  channel is created in `onAttachedToActivity`, so it is null on that path.

## 0.10.0
* Bump TerraAndroid SDK to 1.7.2 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) — fixes Android Health Connect data not syncing. Upgrade recommended for all Android users.
* Android `initTerra`, `initConnection` and `getUserId` now return the real success value from the native SDK instead of always returning `true`.
    - Code that branches on `success` can now take failure paths that previously never fired.

## 0.9.4
* Bump TerraiOS SDK to ~> 1.7.10 — Apple Watch lap/segment fix: laps now follow the user's segment markers, with correct per-segment distance/pace/HR/power (ZD 5587).

## 0.9.3
* Bump TerraiOS SDK to ~> 1.7.9.

## 0.9.2
* Bump TerraiOS SDK to ~> 1.7.7 — planned workout backend sync enabled by default

## 0.9.1
* Bump TerraiOS SDK to 1.7.1 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.9.0
* Bump TerraiOS SDK to 1.7.0 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
    - Uses Swift 6

## 0.8.3
* Bump TerraiOS SDK to 1.6.32 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.8.2
* Bump TerraiOS SDK to 1.6.31 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.6.3 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.8.1
* Bump TerraiOS SDK to 1.6.30 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.8.0
* Bump TerraAndroid SDK to 1.6.0 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)
    - Permissions no longer get requested on initTerra.

## 0.7.9
* Bump TerraAndroid SDK to 1.5.10 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.7.8
* Bump TerraiOS SDK to 1.6.28 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.7.7
* Bump TerraAndroid SDK to 1.5.7 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.7.6
* Bump TerraiOS SDK to 1.6.26 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.7.5
* Bump TerraiOS SDK to 1.6.25 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.5.6 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.7.4
* Bump TerraiOS SDK to 1.6.24 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.5.3 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.7.3
* Bump TerraiOS SDK to 1.6.23 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.7.2
* Bump TerraiOS SDK to 1.6.22 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.5.2 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.7.1
* Bump TerraiOS SDK to 1.6.21 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.5.1 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)

## 0.7.0

* Bump TerraiOS SDK to 1.6.19 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.5.0 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log)
    - Includes support for resource: HEALTH_CONNECT, allowing data aggregated over all sources

## 0.6.9

* Bump TerraiOS SDK to 1.6.16 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.6.8

* Bump TerraiOS SDK to 1.6.16 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.6.7

* Bump TerraiOS SDK to 1.6.13 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump TerraAndroid SDK to 1.4.24 (https://github.com/tryterra/TerraAndroid/wiki/Change-Log) 
    - Added namespace to android build gradle

## 0.6.6

* Bump TerraiOS SDK to 1.6.12 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.6.5

* Bump TerraiOS SDK to 1.6.11 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)

## 0.6.4

* Bump TerraiOS SDK to 1.6.10 (https://github.com/tryterra/TerraiOS/wiki/Change-Log)
* Bump dependency `http` to 1.1.0

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

