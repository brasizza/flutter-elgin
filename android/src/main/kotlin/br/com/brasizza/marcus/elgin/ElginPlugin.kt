package br.com.brasizza.marcus.elgin

import android.app.Activity
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ElginPlugin */
class ElginPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private var channel: MethodChannel? = null
    private var activity: Activity? = null
    private var printer: Printer? = null
    private var binaryMessenger: BinaryMessenger? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("elgin", "onAttachedToEngine")
        binaryMessenger = flutterPluginBinding.binaryMessenger
        // O channel é criado apenas ao anexar a Activity!
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        try {
            when (call.method) {
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }

                "startInternalPrinter" -> {
                    val printerArgs = call.argument<HashMap<String, Any>>("printerArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "printerArgs is null", null)
                    val printerResult = printer?.printerInternalImpStart(printerArgs)
                    result.success(printerResult)
                }

                "stopPrinter" -> {
                    printer?.printerStop()
                    result.success(true)
                }

                "reset" -> {
                    val resetResult = printer?.InicializaImpressora()
                    result.success(resetResult)
                }

                "printText" -> {
                    val textArgs = call.argument<HashMap<String, Any>>("textArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "textArgs is null", null)
                    val printResult = printer?.imprimeTexto(textArgs)
                    result.success(printResult)
                }

                "cutPaper" -> {
                    val linesToCut = call.argument<Int>("lines")
                        ?: return result.error("ARG", "lines is null", null)
                    val cutResult = printer?.cutPaper(linesToCut)
                    result.success(cutResult)
                }

                "feedLine" -> {
                    val linesToJump = call.argument<Int>("lines")
                        ?: return result.error("ARG", "lines is null", null)
                    val jumpResult = printer?.avancaLinhas(linesToJump)
                    result.success(jumpResult)
                }

                "printQrcode" -> {
                    val qrcodeArgs = call.argument<HashMap<String, Any>>("qrcodeArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "qrcodeArgs is null", null)
                    val qrResult = printer?.imprimeQR_CODE(qrcodeArgs)
                    result.success(qrResult)
                }

                "printBarCode" -> {
                    val barcodeArgs = call.argument<HashMap<String, Any>>("barcodeArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "barcodeArgs is null", null)
                    val barResult = printer?.imprimeBarCode(barcodeArgs)
                    result.success(barResult)
                }

                "printImage" -> {
                    val imageArgs = call.argument<HashMap<String, Any>>("imageArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "imageArgs is null", null)
                    val imgResult = printer?.imprimeImagem(imageArgs)
                    result.success(imgResult)
                }

                "printRaw" -> {
                    val rawArgs = call.argument<HashMap<String, Any>>("rawArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "rawArgs is null", null)
                    val rawResult = printer?.printRaw(rawArgs)
                    result.success(rawResult)
                }

                "statusSensor" -> {
                    val statusSensor = printer?.statusSensorPapel()
                    result.success(statusSensor)
                }

                "statusEjector" -> {
                    val statusEjector = printer?.statusEjetor()
                    result.success(statusEjector)
                }

                "statusCashier" -> {
                    val statusCashier = printer?.statusGaveta()
                    result.success(statusCashier)
                }

                "elginCashier" -> {
                    val elginCashier = printer?.abrirGavetaElgin()
                    result.success(elginCashier)
                }

                "customCashier" -> {
                    val cashierArgs = call.argument<HashMap<String, Any>>("cashierArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "cashierArgs is null", null)
                    val customCashier = printer?.abrirGaveta(cashierArgs)
                    result.success(customCashier)
                }

                "beep" -> {
                    val beepArgs = call.argument<HashMap<String, Any>>("beepArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "beepArgs is null", null)
                    val beepReturn = printer?.sinalSonoro(beepArgs)
                    result.success(beepReturn)
                }

                "libVersion" -> {
                    val versionReturn = printer?.versaoImpressora()
                    result.success(versionReturn)
                }

                "printSAT" -> {
                    val satArgs = call.argument<HashMap<String, Any>>("satArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "satArgs is null", null)
                    val xmlSatReturn = printer?.imprimeXMLSAT(satArgs)
                    result.success(xmlSatReturn)
                }

                "printNFCE" -> {
                    val nfceArgs = call.argument<HashMap<String, Any>>("nfceArgs") as Map<String, Any>?
                        ?: return result.error("ARG", "nfceArgs is null", null)
                    val xmlNfceReturn = printer?.imprimeXMLNFCe(nfceArgs)
                    result.success(xmlNfceReturn)
                }

                "printTEF" -> {
                    val cupomTEF = call.argument<String>("cupomTEF")
                        ?: return result.error("ARG", "cupomTEF is null", null)
                    val tefReturn = printer?.imprimeCupomTEF(cupomTEF)
                    result.success(tefReturn)
                }

                else -> {
                    result.notImplemented()
                }
            }
        } catch (e: Exception) {
            result.error("EXCEPTION", e.message, null)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    // ActivityAware implementations
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        printer = Printer(activity!!)
        channel = MethodChannel(binaryMessenger!!, "elgin")
        channel?.setMethodCallHandler(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
        printer = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }
}
