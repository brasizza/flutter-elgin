package br.com.brasizza.marcus.elgin;

import android.app.Activity;
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
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;






/** ElginPlugin */
public class ElginPlugin implements FlutterPlugin, MethodCallHandler , ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private Activity activity;
  private Printer printer;
  private BinaryMessenger binaryMessenger;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        Log.d("elgin" , "onAttachedToEngine");

    this.binaryMessenger = flutterPluginBinding.getBinaryMessenger();
  
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch(call.method){
      default:
        result.notImplemented();
      case "getPlatformVersion":
       result.success("Android " + android.os.Build.VERSION.RELEASE);
      break;

      case "startInternalPrinter":
        HashMap printerArgs = call.argument("printerArgs");
        int resultPrinter = printer.printerInternalImpStart(printerArgs);
        result.success(resultPrinter);
        break;

      case "stopPrinter":
        printer.printerStop();
        result.success(true);
        break;


      case "reset":
        int resultReset = printer.InicializaImpressora();
        result.success(resultReset);
        break;

      case "printText":
        HashMap map = call.argument("textArgs");
        int resultPrintText = printer.imprimeTexto(map);
        result.success(resultPrintText);
        break;
        
      case "cutPaper":
        int linesToCut = call.argument("lines");
        int resultCut = printer.cutPaper(linesToCut);
        result.success(resultCut);

        break;

      case "feedLine":
        int linesToJump = call.argument("lines");
        int resultJump = printer.avancaLinhas(linesToJump);
        result.success(resultJump);
        break;


      case "printQrcode":
        HashMap qrcodeArgs = call.argument("qrcodeArgs");
        int resultQrcode = printer.imprimeQR_CODE(qrcodeArgs);
        result.success(resultQrcode);

        break;

      case "printBarCode":
        HashMap barcodeArgs = call.argument("barcodeArgs");
        int resultBarCode = printer.imprimeBarCode(barcodeArgs);
        result.success(resultBarCode);

        break;

      case "printImage":
        HashMap imageArgs = call.argument("imageArgs");
        int resultImage = printer.imprimeImagem(imageArgs);
        result.success(resultImage);

        break;


      case "printRaw":
        HashMap rawArgs = call.argument("rawArgs");
        int resultRaw = printer.printRaw(rawArgs);
        result.success(resultRaw);
        break;


      case "statusSensor":
        int statusSensor = printer.statusSensorPapel();
        result.success(statusSensor);
        break;


      case "statusEjector":
        int statusEjetor = printer.statusEjetor();
        result.success(statusEjetor);
        break;

      case "statusCashier":
        int statusCashier = printer.statusGaveta();
        result.success(statusCashier);
        break;

      case "elginCashier":
        int elginCashier = printer.abrirGavetaElgin();
        result.success(elginCashier);
        break;


      case "customCashier":
        HashMap casherArgs = call.argument("cashierArgs");
        int customCashier = printer.abrirGaveta(casherArgs);
        result.success(customCashier);
        break;


      case "beep":
        HashMap beepArgs = call.argument("beepArgs");
        int beepReturn = printer.sinalSonoro(beepArgs);
        result.success(beepReturn);
        break;

      case "libVersion":
        String versionReturn = printer.versaoImpressora();
        result.success(versionReturn);
        break;


      case "printSAT":
        HashMap satArgs = call.argument("satArgs");
        int xmlSatReturn = printer.imprimeXMLSAT(satArgs);
        result.success(xmlSatReturn);
        break;


      case "printNFCE":
        HashMap nfceArgs = call.argument("nfceArgs");
        int xmlNfceReturn = printer.imprimeXMLNFCe(nfceArgs);
        result.success(xmlNfceReturn);
        break;


      case "printTEF":
       String cupomTEF =  (String) call.argument("cupomTEF");
        int tefReturn = printer.imprimeCupomTEF(cupomTEF);
        result.success(tefReturn);
        break;

    }

  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }


  @Override
public void onAttachedToActivity(ActivityPluginBinding binding) {

    activity = binding.getActivity();
    printer = new Printer(activity);

    channel  = new MethodChannel(this.binaryMessenger, "elgin");
    channel.setMethodCallHandler(this);


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