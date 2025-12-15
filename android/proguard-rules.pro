# Keep all Terra plugin classes
-keep class co.tryterra.terra.** { *; }
-keepclassmembers class co.tryterra.terra.** { *; }

# Keep Terra Flutter bridge classes
-keep class co.tryterra.terra_flutter_bridge.** { *; }
-keepclassmembers class co.tryterra.terra_flutter_bridge.** { *; }

# GSON rules for Terra SDK
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }

# Keep all data classes used by Terra SDK
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Prevent R8 from stripping TypeToken
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken

# Keep GSON adapters
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Kotlin Coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
-keep class kotlinx.coroutines.** { *; }
