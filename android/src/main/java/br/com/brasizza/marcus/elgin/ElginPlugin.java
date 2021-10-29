package br.com.brasizza.marcus.elgin;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;




/** ElginPlugin */
public class ElginPlugin implements FlutterPlugin, MethodCallHandler , ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private Activity activity;

  private Printer printer;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    Log.d("elgin" , "onAttachedToEngine");
    channel  = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "elgin");
    channel.setMethodCallHandler(this);



  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    Log.d("elgin" , "onMethodCall");
    Log.d("elgin" , call.method);

    switch(call.method){


      default:
        result.notImplemented();
      case "getPlatformVersion":
       result.success("Android " + android.os.Build.VERSION.RELEASE);
      break;

      case "startInternalPrinter":
        int resultPrinter = printer.printerInternalImpStart();
        Log.d("elgin" , "startInternalPrinter " + resultPrinter);
        result.success(resultPrinter);
        break;

      case "stopPrinter":
        printer.printerStop();
        result.success(true);
        break;

      case "printText":
        HashMap map = call.argument("textArgs");
        int resultPrintText = printer.imprimeTexto(map);
        Log.d("elgin" , "printText " + resultPrintText);
        result.success(resultPrintText);
        break;
        
      case "cutPaper":
        int linesToCut = call.argument("lines");
        int resultCut = printer.cutPaper(linesToCut);
        Log.d("elgin" , "cut " + resultCut);
        result.success(resultCut);

        break;

      case "feedLine":
        int linesToJump = call.argument("lines");
        int resultJump = printer.avancaLinhas(linesToJump);
        Log.d("elgin" , "jumpLine " + resultJump);
        result.success(resultJump);

        break;


      case "printQrcode":
        HashMap qrcodeArgs = call.argument("qrcodeArgs");
        int resultQrcode = printer.imprimeQR_CODE(qrcodeArgs);
        Log.d("elgin" , "printQrcode " + resultQrcode);
        result.success(resultQrcode);

        break;

      case "printBarCode":
        HashMap barcodeArgs = call.argument("barcodeArgs");
        int resultBarCode = printer.imprimeBarCode(barcodeArgs);
        Log.d("elgin" , "printBarCode " + resultBarCode);
        result.success(resultBarCode);

        break;

      case "printImage":
        HashMap imageArgs = call.argument("imageArgs");
        int resultImage = printer.imprimeImagem(imageArgs);
        Log.d("elgin" , "printImage " + resultImage);
        result.success(resultImage);

        break;


    }

  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }


  @Override
public void onAttachedToActivity(ActivityPluginBinding binding) {
    Log.d("elgin" , "onMethodCall");
    activity = binding.getActivity();
    printer = new Printer(activity);
}

  @Override
public void  onDetachedFromActivity(){

}

@Override
public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    onAttachedToActivity(binding);
}

@Override
public void onDetachedFromActivityForConfigChanges(){}
}