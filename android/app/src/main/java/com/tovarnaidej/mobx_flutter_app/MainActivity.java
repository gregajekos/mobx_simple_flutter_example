package com.tovarnaidej.mobx_flutter_app;

import android.os.Bundle;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import polar.com.sdk.api.PolarBleApi;
import polar.com.sdk.api.PolarBleApiCallback;
import polar.com.sdk.api.PolarBleApiDefaultImpl;
import polar.com.sdk.api.errors.PolarInvalidArgument;
import polar.com.sdk.api.model.PolarDeviceInfo;
import polar.com.sdk.api.model.PolarHrData;

public class MainActivity extends FlutterActivity {


    public static final String UPDATECHANNEL = "com.tovarnaidej.eclipse/blestream";
    public static final String UPDATECALLBACK = "updateHrCallback";
    public static final String CHANNEL = "com.tovarnaidej.eclipse";

    HashMap<String, PolarBleApi> listDevices;
    MethodChannel updateChannel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        GeneratedPluginRegistrant.registerWith(this);
        updateChannel = new MethodChannel(getFlutterView(), CHANNEL);
        updateChannel.setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {

                        if (call.method.equals("setDeviceAddress")) {
                            if (call.arguments != null && call.hasArgument("address")) {
                                Log.d("MyApp", "imamo address " + call.argument("address").toString());
                                addDevice(call.argument("address").toString());
                            }

                        } else {
                            result.notImplemented();
                        }
                    }
                });


    }

    public void addDevice(String address) {
        if (listDevices == null) {
            listDevices = new HashMap<>();
        }

        PolarBleApi api = PolarBleApiDefaultImpl.defaultImplementation(this, PolarBleApi.ALL_FEATURES);
        api.setApiCallback(new PolarBleApiCallback() {

            @Override
            public void deviceConnected(PolarDeviceInfo polarDeviceInfo) {
                Log.d("MyApp", "CONNECTED: " + polarDeviceInfo.deviceId);
                listDevices.put(address, api);
                super.deviceConnected(polarDeviceInfo);
            }

            @Override
            public void deviceConnecting(PolarDeviceInfo polarDeviceInfo) {
                Log.d("MyApp", "CONNECTING: " + polarDeviceInfo.deviceId);

                super.deviceConnecting(polarDeviceInfo);
            }

            @Override
            public void deviceDisconnected(PolarDeviceInfo polarDeviceInfo) {
                Log.d("MyApp", "DISCONNECTED: " + polarDeviceInfo.deviceId);

                super.deviceDisconnected(polarDeviceInfo);
            }

            @Override
            public void disInformationReceived(String identifier, UUID uuid, String value) {
                super.disInformationReceived(identifier, uuid, value);
            }

            @Override
            public void blePowerStateChanged(boolean powered) {
                Log.d("MyApp", "BLE power: " + powered);
            }

            @Override
            public void ecgFeatureReady(String identifier) {
            }

            @Override
            public void accelerometerFeatureReady(String identifier) {
            }

            @Override
            public void ppgFeatureReady(String identifier) {
            }

            @Override
            public void ppiFeatureReady(String identifier) {
            }

            @Override
            public void biozFeatureReady(String identifier) {
            }

            @Override
            public void hrFeatureReady(String identifier) {
                Log.d("MyApp", "HR READY: " + identifier);
            }

            @Override
            public void batteryLevelReceived(String identifier, int level) {
            }

            @Override
            public void hrNotificationReceived(String identifier, PolarHrData data) {
                Log.d("MyApp", "HR: " + data.hr);

                if (updateChannel != null) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("hrValue", data.hr);
                    map.put("from", address);
                    updateChannel.invokeMethod(UPDATECALLBACK, map);
                }

            }

            @Override
            public void polarFtpFeatureReady(String s) {
            }
        });

        try {
            api.connectToDevice(address);
            Log.d("MyApp", "connecting to " + address);

        } catch (PolarInvalidArgument polarInvalidArgument) {
            polarInvalidArgument.printStackTrace();
        }

    }

    @Override
    public void onPause() {
        super.onPause();

        if (listDevices != null) {
            for (PolarBleApi api : listDevices.values()) {
                api.backgroundEntered();

            }
        }

    }

    @Override
    public void onResume() {
        super.onResume();

        if (listDevices != null) {
            for (PolarBleApi api : listDevices.values()) {
                api.foregroundEntered();

            }
        }


    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        if (listDevices != null) {
            for (PolarBleApi api : listDevices.values()) {
                api.shutDown();

            }
        }
    }
}
