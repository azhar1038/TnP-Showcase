package com.az.igit.tnp;

import android.os.Bundle;
import android.content.Intent;
import android.net.Uri;
import android.content.pm.PackageManager;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.az.igit.tnp";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler(){
      @Override
      public void onMethodCall(MethodCall methodCall, Result result){
        if(methodCall.method.equals("webIntent")){
          String url = methodCall.argument("url");
          webIntent(url);
        }else if(methodCall.method.equals("emailIntent")){
          String to = methodCall.argument("to");
          String subject = methodCall.argument("subject");
          String body = methodCall.argument("body");
          emailIntent(to, subject, body);
        }
        result.success("Done");
      }
    });

  }

  private void webIntent(String url){
    Uri uri = Uri.parse(url);
    Intent intent = new Intent(Intent.ACTION_VIEW, uri);
    if (intent.resolveActivity(getPackageManager()) != null) {
      startActivity(Intent.createChooser(intent, "Open using..."));
    }
  }

  private void emailIntent(String to, String subject, String body){
    Intent email = new Intent(Intent.ACTION_VIEW);
    email.setData(Uri.parse("mailto:"+to+"?&subject="+subject+"&body="+body));
    // email.setData(Uri.parse("mailto:"+to));
    // email.putExtra(Intent.EXTRA_EMAIL, new String[]{to});
    // email.putExtra(Intent.EXTRA_SUBJECT, subject);
    // email.putExtra(Intent.EXTRA_TEXT, body);
    // email.setType("text/plain");
    if (email.resolveActivity(getPackageManager()) != null) {
      startActivity(Intent.createChooser(email, "Send using..."));
    }
  }
}
