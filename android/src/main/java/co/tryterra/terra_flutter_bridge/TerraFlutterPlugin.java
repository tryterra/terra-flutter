package co.tryterra.terra_flutter_bridge;

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

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

import com.google.gson.Gson;

import co.tryterra.terra.enums.Connections;
import co.tryterra.terra.enums.Permissions;
import co.tryterra.terra.Terra;
import kotlin.Unit;

/** TerraFlutterPlugin */
public class TerraFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  private FlutterActivity activity = null;
  private BinaryMessenger binaryMessenger = null;

  private Gson gson = new Gson();

  public Terra terra;

  // parsing
  private Connections parseConnection(String connection){
    switch (connection){
        case "SAMSUNG":
            return Connections.SAMSUNG;
        case "GOOGLE":
            return Connections.GOOGLE_FIT;
        case "FREESTYLE_LIBRE":
            return Connections.FREESTYLE_LIBRE;
    }
    return null;
  }

  private void testFunction(String text, @NonNull Result result){
    result.success(text);
  }


  // init
  private void initTerra(
    String devID,
    String referenceId,
    Result result
  ) {
    try{
      this.terra = new Terra(
        devID,
        Objects.requireNonNull(this.context),
        referenceId,
        (success) -> {
          result.success(success);
          return Unit.INSTANCE;
        }
      );
    }
    catch(Exception e){
      result.error("Init Failure", "Could not initialise Terra", e);
      result.success(false);
    }
  }

  private void initConnection(
    String connection,
    String token,
    Boolean schedulerOn,
    ArrayList<String> customPermissions,
    Result result
  ){
    if (parseConnection(connection) == null){
        result.error("Connection Failure", "Invalid Connection has been passed for the android platform", null);
        return;
    }

    this.terra.initConnection(
      Objects.requireNonNull(parseConnection(connection)),
      token, Objects.requireNonNull(this.context),
      schedulerOn,
      null,
      (success)-> {
        result.success(success);
        return Unit.INSTANCE;
      });
  }

  private void getUserId(String connection, Result result){
    try {
      result.success(terra.getUserId(
        Objects.requireNonNull(parseConnection(connection))
      ));
    }
    catch(Exception e) {
      result.error("Getter Failure", "Could not get user id", e);
    }
  }

  // getters
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
  }

  // freestyle
  private void readGlucoseData(Result result){
    try{
      this.terra.readGlucoseData((details) -> {
        result.success(gson.toJson(details));
        return Unit.INSTANCE;
      });
    }
    catch(Exception e){
      result.error("Sensor Activation Failure", "Could not activate freestyle sensor", e);
    }
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    binaryMessenger = flutterPluginBinding.getBinaryMessenger();
    // this.context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding){
    this.context = (Context) binding.getActivity();
    channel = new MethodChannel(binaryMessenger, "terra_flutter_bridge");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

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
          call.argument("referenceID"),
          result
        );
        break;
      case "initConnection":
        initConnection(
          call.argument("connection"),
          call.argument("token"),
          call.argument("schedulerOn"),
          call.argument("customPermissions"),
          result
        );
        break;
      case "getActivity":
        getActivity(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from(Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getBody":
        getBody(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from(Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getDaily":
        getDaily(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from(Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getNutrition":
        getNutrition(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from(Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getSleep":
        getSleep(
          call.argument("connection"),
          Date.from(Instant.parse(call.argument("startDate"))),
          Date.from(Instant.parse(call.argument("endDate"))),
          result
        );
        break;
      case "getAthlete":
        getAthlete(
          call.argument("connection"),
          result
        );
        break;
      case "readGlucoseData":
        readGlucoseData(
          result
        );
        break;
      case "getUserId":
        getUserId(
          call.argument("connection"), 
          result
        );
        break;
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
