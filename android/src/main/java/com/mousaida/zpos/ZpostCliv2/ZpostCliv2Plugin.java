package com.mousaida.zpos.ZpostCliv2;

import android.annotation.SuppressLint;
import android.app.Activity;

import android.content.Context;
import android.content.Intent;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.pdf.PdfDocument;
import android.graphics.pdf.PdfRenderer;
import android.net.Uri;
import android.os.*;
import android.os.Process;
import android.text.Layout;
import android.util.Base64;
import android.util.Log;
import androidx.annotation.NonNull;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import com.imagpay.PrnStrFormat;
import com.imagpay.Settings;
import com.imagpay.mpos.MposHandler;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityControlSurface;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/** ZpostCliv2Plugin */
public class ZpostCliv2Plugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private static final String TAG = "hiss" ;
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private MposHandler handler;
  private Settings setting;
  private Activity activity;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ZpostCliv2");
    this.context = flutterPluginBinding.getApplicationContext();
    channel.setMethodCallHandler(this);
  }


  public boolean initSdk() {
    handler = MposHandler.getInstance(this.activity);
    handler.setShowLog(true);
    // add linstener for connection
    //handler.addSwipeListener(this);
    setting = Settings.getInstance(handler);
    // power on the device when you need to read card or print
    setting.mPosPowerOn();
    try {
      // for 90,delay 1S and then connect
      // Thread.sleep(1000);
      // connect device via serial port
      if (!handler.isConnected()) {
        System.out.println("Connect Res:" + handler.connect());
      } else {
        handler.close();
        System.out.println("ReConnect Res:" + handler.connect());
      }
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return false;

    }
    return true;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

  if (call.method.equals("initSdk")) {
      result.success(initSdk());
    } else if (call.method.equals("printTicket")) {
       String file = call.argument("file");
      result.success(printTicketBit(file));
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull @org.jetbrains.annotations.NotNull ActivityPluginBinding activityPluginBinding) {
    this.activity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull @org.jetbrains.annotations.NotNull ActivityPluginBinding activityPluginBinding) {

  }

  @Override
  public void onDetachedFromActivity() {


  }

  private static Bitmap resize(Bitmap image, int maxWidth, int maxHeight) {
    if (maxHeight > 0 && maxWidth > 0) {
      int width = image.getWidth();
      int height = image.getHeight();
      float ratioBitmap = (float) width / (float) height;
      float ratioMax = (float) maxWidth / (float) maxHeight;

      int finalWidth = maxWidth;
      int finalHeight = maxHeight;
      if (ratioMax > ratioBitmap) {
        finalWidth = (int) ((float)maxHeight * ratioBitmap);
      } else {
        finalHeight = (int) ((float)maxWidth / ratioBitmap);
      }
      image = Bitmap.createScaledBitmap(image, finalWidth, finalHeight, true);
      return image;
    } else {
      return image;
    }
  }

  private boolean printTicketBit(String paths)  {
    byte[] bytes= Base64.decode(paths,Base64.NO_CLOSE);
    BitmapFactory.Options opt = new BitmapFactory.Options();
    opt.inPreferredConfig = Bitmap.Config.RGB_565;
    opt.inPurgeable = true;
    opt.inInputShareable = true;
    Bitmap bitmap=  BitmapFactory.decodeByteArray(bytes, 0, bytes.length,opt);

    final Bitmap newbitmap=  resize(bitmap,342, bitmap.getHeight()+100);
    try {


      new Thread(new Runnable() {
        @Override
        public void run() {
          Process.setThreadPriority(-20);

          setting.prnBitmap(newbitmap);
          setting.prnStart();
        }}).start();
      }catch(Exception e){
          e.printStackTrace();
      }
    
    return  true;

    
  }
}

