/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.FichaTecnicaAD;
import com.fshoes.entidades.FichaTecnica;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class FichaTecnicaLN {
    
    // singleton
    public static FichaTecnicaLN _Instancia;

    private FichaTecnicaLN() {};
	public static FichaTecnicaLN Instancia() {
        if (_Instancia == null) {
            _Instancia = new FichaTecnicaLN();
        }
        return _Instancia;
    }
    // end Singleton
    
    public ArrayList<FichaTecnica> listarFichaTecnica(String valor, String prm, int inicio, int fin) throws Exception {
        try {
            if(!prm.equals(""))            
                return FichaTecnicaAD.Instancia().listarFichaTecnica(valor, prm, inicio, fin);
            else return null;
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    public ArrayList<FichaTecnica> listarFichaTecnica(String valor, String prm) throws Exception {
        try {
            if(!prm.equals(""))            
                return FichaTecnicaAD.Instancia().listarFichaTecnica(valor, prm);
            else return null;
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    public boolean registrarFichaTecnica(FichaTecnica objFicha, String prm) throws Exception {        
        try {            
            if(objFicha != null && !(prm.equals(""))){
                if(!objFicha.getCodigoficha().equals("") && !objFicha.getObjModelo().getCodigomodelo().equals(""))
                    return FichaTecnicaAD.Instancia().registrarFichaTecnica(objFicha, prm);
                else return false;
            }else{
                return false;
            }            
        } catch (Exception e) {
            throw e;
        }
    }
    
    public int existeFichaTecnica(String valor, String prm) throws Exception{
        try {
            if (!(prm.equals("")) && !valor.equals(""))
                return FichaTecnicaAD.Instancia().existeFichaTecnica(valor, prm);
            else return 0;
        } catch (Exception e) {
            throw e;
        }        
    }
    
}
