
# flutter_file_picker
-keep class com.mr.flutter.plugin.filepicker.** { *; }
-keep class androidx.lifecycle.DefaultLifecycleObserver

# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.firebase.perf.network.FirebasePerfUrlConnection


#To Disable Log In Realse Mode
-assumenosideeffects class android.util.Log {
public static int v(...);
public static int i(...);
public static int w(...);
public static int d(...);
public static int e(...);
}
