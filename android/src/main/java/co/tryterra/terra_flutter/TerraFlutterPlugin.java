package co.tryterra.terra_flutter;

import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import co.tryterra.terra.*;

/** TerraFlutterPlugin */
public class TerraFlutterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  public Terra terra;

  private Connections parseConnection(String connection){
    switch (connection){
        case "SAMSUNG":
            return Connections.SAMSUNG;
        case "GOOGLE_FIT":
            return Connections.GOOGLE_FIT;
        case "FREESTYLE_LIBRE":
            return Connections.FREESTYLE_LIBRE;
    }
    return null;
  }

  private void testFunction(String text, @NonNull Result result){
    result.success(text);
  }

  private void initTerra(
    String devID,
    String apiKey,
    String referenceId,
    int intervalMinutes,
    ArrayList<String> connectionsStr,
    ArrayList<String> permissionsStr,
    Result result
  ) {
    this.terra = new Terra(
            devID,
            apiKey,
      Objects.requireNonNull(this.getCurrentActivity()),
            intervalMinutes * 60 * 1000,
            intervalMinutes * 60 * 1000,
            intervalMinutes * 60 * 1000,
            intervalMinutes * 60 * 1000,
            intervalMinutes * 60 * 1000,
            referenceId,
            null
            );
    for (String connection : connectionsStr) {
      switch (connection) {
        case "SAMSUNG":
          terra.initConnection(
            Connections.SAMSUNG,
            this.getCurrentActivity(),
            new HashSet<>(Arrays.asList(Permissions.ACTIVITY, Permissions.ATHLETE, Permissions.BODY, Permissions.DAILY, Permissions.NUTRITION, Permissions.SLEEP)),
            null
          );
          break;
        case "GOOGLE":
          terra.initConnection(
              Connections.GOOGLE_FIT,
              this.getCurrentActivity(),
              new HashSet<>(Arrays.asList(Permissions.ACTIVITY, Permissions.ATHLETE, Permissions.BODY, Permissions.DAILY, Permissions.NUTRITION, Permissions.SLEEP)),
            null
          );
          break;
        case "FREESTYLE_LIBRE":
          terra.initConnection(
              Connections.FREESTYLE_LIBRE,
              this.getCurrentActivity(),
              new HashSet<>(),
              null
          );
          break;
        default:
          break;
      }
    }
    result.success(true);
}
  private void checkAuth(String connection){}
  private void getAthlete(String co){}
  private void getActivity(){}
  private void getBody(){}
  private void getDaily(){}
  private void getNutrition(){}
  private void getSleep(){}
  private void deauth(){}

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "terra_flutter");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "testFunction":
        testFunction(call.argument("text"), result);
        break;
      // case "initTerra":
      //   initTerra();
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

}
