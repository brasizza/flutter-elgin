package br.com.brasizza.marcus.elgin

import android.app.Activity
import android.util.Base64
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Log
import com.elgin.e1.Impressora.Termica
import com.elgin.e1.Impressora.Utilidades.RetornoPOS
import java.io.File

class Printer(private val mActivity: Activity) {

    init {
        Termica.setActivity(this.mActivity)
    }

    fun printerInternalImpStart(map: Map<String, Any>): Int {
        val typeImp = map["type"] as Int
        val modelImp = map["model"] as String
        val connImp = map["connection"] as String
        val paramImp = map["param"] as Int

        Log.d("elgin", "close connection")
        printerStop()
        Log.d("elgin", "printer closed")

        Log.d("elgin", "typeImp = $typeImp")
        Log.d("elgin", "modelImp = $modelImp")
        Log.d("elgin", "connImp = $connImp")
        Log.d("elgin", "paramImp = $paramImp")

        return Termica.AbreConexaoImpressora(typeImp, modelImp, connImp, paramImp)
    }

    fun printerStop() {
        Termica.FechaConexaoImpressora()
    }

    fun avancaLinhas(lines: Int): Int {
        return Termica.AvancaPapel(lines)
    }

    fun cutPaper(lines: Int): Int {
        return Termica.Corte(lines)
    }

    fun imprimeTexto(map: Map<String, Any>): Int {
        val text = map["text"] as String
        val align = map["align"] as Int
        val font = map["font"] as Int
        val fontSize = map["fontSize"] as Int
        return Termica.ImpressaoTexto(text, align, font, fontSize)
    }

    fun imprimeBarCode(map: Map<String, Any>): Int {
        val text = map["text"] as String
        val barCodeType = map["barCodeType"] as Int
        val height = map["height"] as Int
        val width = map["width"] as Int
        val textPosition = map["textPosition"] as Int
        val align = map["align"] as Int
        Termica.DefinePosicao(align)
        return Termica.ImpressaoCodigoBarras(barCodeType, text, height, width, textPosition)
    }

    fun imprimeQR_CODE(map: Map<String, Any>): Int {
        val size = map["size"] as Int
        val text = map["text"] as String
        val align = map["align"] as Int
        val correctionLevel = map["correction"] as Int
        Termica.DefinePosicao(align)
        return Termica.ImpressaoQRCode(text, size, correctionLevel)
    }

    fun printRaw(map: Map<String, Any>): Int {
        val dataRaw = map["data"] as ByteArray
        val totalbytes = map["bytes"] as Int
        val leu = RetornoPOS(1)
        val ler = ByteArray(1000)
        return Termica.DirectIO(dataRaw, totalbytes, ler, leu)
    }

    fun imprimeImagem(map: Map<String, Any>): Int {
        val pathImage = map["path"] as String
        val isBase64 = map["isBase64"] as Boolean
        val bitmap: Bitmap = if (isBase64) {
            val decodedString = Base64.decode(pathImage, Base64.DEFAULT)
            BitmapFactory.decodeByteArray(decodedString, 0, decodedString.size)
        } else {
            val mSaveBit = File(pathImage)
            val filePath = mSaveBit.path
            BitmapFactory.decodeFile(filePath)
        }
        return Termica.ImprimeBitmap(bitmap)
    }

    fun imprimeXMLNFCe(map: Map<String, Any>): Int {
        val xmlNFCe = map["xmlNFCe"] as String
        println(xmlNFCe)
        val indexcsc = map["indexcsc"] as Int
        val csc = map["csc"] as String
        val param = map["param"] as Int
        return Termica.ImprimeXMLNFCe(xmlNFCe, indexcsc, csc, param)
    }

    fun imprimeXMLSAT(map: Map<String, Any>): Int {
        val xml = map["xmlSAT"] as String
        val param = map["param"] as Int
        return Termica.ImprimeXMLSAT(xml, param)
    }

    fun imprimeCupomTEF(cupomTEF: String): Int {
        return Termica.ImprimeCupomTEF(cupomTEF)
    }

    fun statusGaveta(): Int {
        return Termica.StatusImpressora(1)
    }

    fun statusSensorPapel(): Int {
        return Termica.StatusImpressora(3)
    }

    fun statusEjetor(): Int {
        return Termica.StatusImpressora(4)
    }

    fun abrirGavetaElgin(): Int {
        return Termica.AbreGavetaElgin()
    }

    fun abrirGaveta(map: Map<String, Any>): Int {
        val pin = map["pin"] as Int
        val it = map["it"] as Int
        val dp = map["dp"] as Int
        return Termica.AbreGaveta(pin, it, dp)
    }

    fun sinalSonoro(map: Map<String, Any>): Int {
        val qtdSinal = map["times"] as Int
        val st = map["st"] as Int
        val ft = map["ft"] as Int
        return Termica.SinalSonoro(qtdSinal, st, ft)
    }

    fun versaoImpressora(): String {
        return Termica.GetVersaoDLL()
    }

    fun InicializaImpressora(): Int {
        return Termica.InicializaImpressora()
    }
}
