package br.com.brasizza.marcus.elgin;
import android.app.Activity;
import android.util.Base64;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;

import com.elgin.e1.Impressora.Termica;
import com.elgin.e1.Impressora.Utilidades.Inteiro;

import java.io.File;
import java.util.Map;

public class Printer {
    
    Activity mActivity;

    public Printer(Activity activity) {
        this.mActivity = activity;
        Termica.setActivity(this.mActivity);

    }

    public int printerInternalImpStart(Map map) {
        int typeImp =  (Integer) map.get("type");
        String modelImp =  (String) map.get("model");
        String connImp =  (String) map.get("connection");
        int paramImp =  (Integer) map.get("param");

        Log.d("elgin" ,"close connection");
        printerStop();
        Log.d("elgin" ,"printer closed");

        Log.d("elgin" ,"typeImp = "+ typeImp);
        Log.d("elgin" ,"modelImp = "+ modelImp);
        Log.d("elgin" ,"connImp = "+ connImp);
        Log.d("elgin" ,"paramImp = "+ paramImp);

        int result = Termica.AbreConexaoImpressora(typeImp, modelImp, connImp, paramImp);
        return result;
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





    public int imprimeBarCode(Map map) {
        String text = (String) map.get("text");
        int barCodeType =  (Integer) map.get("barCodeType");
        int height = (Integer) map.get("height");
        int width = (Integer) map.get("width");
        int textPosition = (Integer) map.get("textPosition");
        int align = (Integer) map.get("align");
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


    public int printRaw(Map map) {
        byte[]  dataRaw =  (byte[]) map.get("data");
        int totalbytes = (Integer) map.get("bytes");
        Inteiro leu = new Inteiro(1);
        byte[] ler = new byte[1000];
        int ret =  Termica.DirectIO(dataRaw,totalbytes , ler, leu);
        return ret;

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

    public int statusSensorPapel() {
        return Termica.StatusImpressora(3);
    }

    public int statusEjetor() {
        return Termica.StatusImpressora(4);
    }

    public int abrirGavetaElgin() { return Termica.AbreGavetaElgin(); }

    public int abrirGaveta(Map map){
        int pin = (int) map.get("pin");
        int it = (int) map.get("it");
        int dp = (int) map.get("dp");
        return Termica.AbreGaveta(pin,it,dp);
    }


    public int sinalSonoro(Map map){
        int qtdSinal = (int) map.get("times");
        int st = (int) map.get("st");
        int ft = (int) map.get("ft");
        return Termica.SinalSonoro(qtdSinal,st,ft);
    }


    public String versaoImpressora(){
        return Termica.GetVersaoDLL();
    }


    public int InicializaImpressora(){ return  Termica.InicializaImpressora(); }

}
