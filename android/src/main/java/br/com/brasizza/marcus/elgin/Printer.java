package br.com.brasizza.marcus.elgin;
import android.app.Activity;
import android.util.Base64;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;

import com.elgin.e1.Impressora.Termica;

import java.io.File;
import java.util.Map;

public class Printer {
    
    Activity mActivity;

    public Printer(Activity activity) {
        this.mActivity = activity;
        Termica.setContext(mActivity);
    }

    public int printerInternalImpStart() {
        printerStop();
        int result = Termica.AbreConexaoImpressora(6, "M8", "", 0);
        return result;
    }

    public int printerExternalImpStart(String ip, int port) {
        printerStop();
        try {
            int result = Termica.AbreConexaoImpressora(3, "I9", ip, port);
            return result;
        }catch (Exception e){
            return printerInternalImpStart();
        }
    }

    public void printerStop() {
        Termica.FechaConexaoImpressora();
    }

    public int avancaLinhas(int lines) {

        return Termica.AvancaPapel(lines);
    }

    public int cutPaper(int lines) {
        return Termica.Corte(lines);
    }

    public int imprimeTexto(Map map) {
        String text = (String) map.get("text");
        int align = (Integer) map.get("align");
        int font = (Integer) map.get("font");
        int fontSize = (Integer) map.get("fontSize");
        int result;
        result = Termica.ImpressaoTexto(text, align, font, fontSize);
        return result;
    }


//    private int codeOfBarCode(String barCodeName) {
//        if (barCodeName.equals("UPC-A"))
//            return 0;
//        else if (barCodeName.equals("UPC-E"))
//            return 1;
//        else if (barCodeName.equals("EAN 13") || barCodeName.equals("JAN 13"))
//            return 2;
//        else if (barCodeName.equals("EAN 8") || barCodeName.equals("JAN 8"))
//            return 3;
//        else if (barCodeName.equals("CODE 39"))
//            return 4;
//        else if (barCodeName.equals("ITF"))
//            return 5;
//        else if (barCodeName.equals("CODE BAR"))
//            return 6;
//        else if (barCodeName.equals("CODE 93"))
//            return 7;
//        else if (barCodeName.equals("CODE 128"))
//            return 8;
//        else return 0;
//    }


    public int imprimeBarCode(Map map) {
        String text = (String) map.get("text");

        Log.d("elgin" , "texto = " + text);

        int barCodeType =  (Integer) map.get("barCodeType");

        Log.d("elgin" , "barCodeType = " + barCodeType);

        int height = (Integer) map.get("height");
        Log.d("elgin" , "height = " + height);
        int width = (Integer) map.get("width");
        Log.d("elgin" , "width = " + width);
        int textPosition = (Integer) map.get("textPosition");
        Log.d("elgin" , "textPosition = " + textPosition);

        int align = (Integer) map.get("align");
        Log.d("elgin" , "align = " + align);

        Termica.DefinePosicao(align);

        return Termica.ImpressaoCodigoBarras(barCodeType, text, height, width, textPosition);
    }

    public int imprimeQR_CODE(Map map) {
        int size = (Integer) map.get("size");
        String text = (String) map.get("text");
        int align =  (Integer) map.get("align");
        int correctionLevel =  (Integer) map.get("correction");
        int result;
        int alignValue;
        Termica.DefinePosicao(align);
        result = Termica.ImpressaoQRCode(text, size, correctionLevel);
        return result;
    }

    public int imprimeImagem(Map map) {
        String pathImage = (String) map.get("path");
        boolean isBase64 = (boolean) map.get("isBase64");

        int result;
        Bitmap bitmap;
        if(isBase64){
            byte[] decodedString = Base64.decode(pathImage, Base64.DEFAULT);
            bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
            
        }else{
            File mSaveBit = new File(pathImage); // Your image file
            String filePath = mSaveBit.getPath();
            bitmap = BitmapFactory.decodeFile(filePath);
        }

        result = Termica.ImprimeBitmap(bitmap);
        return result;
    }

    public int imprimeXMLNFCe(Map map) {
        String xmlNFCe = (String) map.get("xmlNFCe");
        System.out.println(xmlNFCe);
        int indexcsc = (int) map.get("indexcsc");
        String csc = (String) map.get("csc");
        int param = (int) map.get("param");
        return Termica.ImprimeXMLNFCe(xmlNFCe, indexcsc, csc, param);
    }

    public int imprimeXMLSAT(Map map) {
        String xml = (String) map.get("xmlSAT");
        int param = (int) map.get("param");
        return Termica.ImprimeXMLSAT(xml, param);
    }

    public int imprimeCupomTEF(Map map){
        String base64 = (String) map.get("base64");

        return Termica.ImprimeCupomTEF(base64);
    }

    public int statusGaveta() {
        return Termica.StatusImpressora(1);
    }

    public int abrirGaveta() { return Termica.AbreGavetaElgin(); }

    public int statusSensorPapel() {
        return Termica.StatusImpressora(3);
    }
}
