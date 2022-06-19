package co.tryterra.terra_flutter;

import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.function.Function;
import java.util.Date;

import androidx.annotation.NonNull;

import android.content.Context;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

import co.tryterra.terra.*;
import kotlin.Unit;

/** TerraFlutterPlugin */
public class TerraFlutterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;

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
      Objects.requireNonNull(this.context),
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
            this.context,
            new HashSet<>(Arrays.asList(Permissions.ACTIVITY, Permissions.ATHLETE, Permissions.BODY, Permissions.DAILY, Permissions.NUTRITION, Permissions.SLEEP)),
            null
          );
          break;
        case "GOOGLE":
          terra.initConnection(
              Connections.GOOGLE_FIT,
              this.context,
              new HashSet<>(Arrays.asList(Permissions.ACTIVITY, Permissions.ATHLETE, Permissions.BODY, Permissions.DAILY, Permissions.NUTRITION, Permissions.SLEEP)),
            null
          );
          break;
        case "FREESTYLE_LIBRE":
          terra.initConnection(
              Connections.FREESTYLE_LIBRE,
              this.context,
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
  private void checkAuth(String connection, Result result){
    // result.success(!this.terra.getUserId(parseConnection(connection)).equals(""));
  }
  private void getAthlete(String connection, Result result){
    this.terra.getAthlete(
      Objects.requireNonNull(parseConnection(connection)),
      (success, payload) -> {
        result.success(success);
        return Unit.INSTANCE;
      }
    );
  }
  private void getActivity(String connection, Date startDate, Date endDate, Result result){
    this.terra.getActivity(
      Objects.requireNonNull(parseConnection(connection)),
      startDate,
      endDate,
      (success, payload) -> {
        result.success(success);
        return Unit.INSTANCE;
      }
    );
  }
  private void getBody(String connection, Date startDate, Date endDate, Result result){
    this.terra.getBody(
      Objects.requireNonNull(parseConnection(connection)),
      startDate,
      endDate,
      (success, payload) -> {
        result.success(success);
        return Unit.INSTANCE;
      }
    );
    result.success(true);
  }
  private void getDaily(String connection, Date startDate, Date endDate, Result result){
    this.terra.getDaily(
      Objects.requireNonNull(parseConnection(connection)),
      startDate,
      endDate,
      (success, payload) -> {
        result.success(success);
        return Unit.INSTANCE;
      }
    );
    result.success(true);
  }
  private void getNutrition(String connection, Date startDate, Date endDate, Result result){
    this.terra.getNutrition(
      Objects.requireNonNull(parseConnection(connection)),
      startDate,
      endDate,
      (success, payload) -> {
        result.success(success);
        return Unit.INSTANCE;
      }
    );
    result.success(true);
  }
  private void getSleep(String connection, Date startDate, Date endDate, Result result){
    this.terra.getSleep(
      Objects.requireNonNull(parseConnection(connection)),
      startDate,
      endDate,
      (success, payload) -> {
        result.success(success);
        return Unit.INSTANCE;
      }
    );
    result.success(true);
  }
  private void deauth(String connection, Result Result){
    this.terra.disconnect(Objects.requireNonNull(parseConnection(connection)));
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "terra_flutter");
    channel.setMethodCallHandler(this);
    this.context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "testFunction":
        testFunction(call.argument("text"), result);
        break;
      case "initTerra":
        initTerra(
          call.argument("devID"),
          call.argument("apiKey"),
          call.argument("referenceID"),
          call.argument("intervalMinutes"),
          call.argument("connections"),
          call.argument("permissions"),
          result
        );
      // case "checkAuth":
      //   checkAuth(
      //     call.argument("connection"),
      //     result
      //   );
      case "getActivity":
        getActivity(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from( Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getBody":
        getBody(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from( Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getDaily":
        getDaily(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from( Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getNutrition":
        getNutrition(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from( Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getSleep":
        getSleep(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from( Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getAthlete":
        getAthlete(
          call.argument("connection"),
          result
        );
        break;
      case "deauth":
        deauth(
          call.argument("connection"),
          result
        );
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
