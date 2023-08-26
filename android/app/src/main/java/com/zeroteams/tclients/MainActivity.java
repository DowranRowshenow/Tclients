package com.zeroteams.tclients;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.content.IntentFilter;
import android.os.Bundle;
import android.telephony.TelephonyManager;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";    

    private CallReceiver callReceiver;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
            (call, result) -> {
                // This method is invoked on the main thread.
                if (call.method.equals("listenCalls")) {
                    listenCalls();
                    //result.success();
                } else {
                    result.notImplemented();
                }
            }
        );
    }

    private void listenCalls() {
        callReceiver = new CallReceiver();
        IntentFilter filter = new IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED);
        registerReceiver(callReceiver, filter);
    }
}