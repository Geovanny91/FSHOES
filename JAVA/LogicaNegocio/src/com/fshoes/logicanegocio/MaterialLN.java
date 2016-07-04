/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.MaterialAD;
import com.fshoes.entidades.Material;
import java.util.ArrayList;

/**
 *
 * @author Geovanny
 */
public class MaterialLN {
    
    // singleton
    public static MaterialLN _Instancia;
    private MaterialLN() {};
    public static MaterialLN Instancia() {
        if (_Instancia == null) {
            _Instancia = new MaterialLN();
        }
        return _Instancia;
    }
    // end Singleton
    
    public ArrayList<Material> listarMaterial(String valor, String prm, int inicio, int fin) throws Exception {
        try {
            if(!prm.equals(""))
                return MaterialAD.Instancia().listarMaterial(valor, prm, inicio, fin);//validar con el parámetro
            else return null;
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    public ArrayList<Material> listarMaterial(String valor, String prm) throws Exception {
        try {
            if(!prm.equals("") && !valor.equals(""))
                return MaterialAD.Instancia().listarMaterial(valor, prm);//validar con el parámetro
            else return null;
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    public ArrayList<Material> obtenerMaterialesPorFichaTecnica(String valor, String prm) throws Exception {
        try {
            if(!prm.equals("") && !valor.equals(""))
                return MaterialAD.Instancia().obtenerMaterialesPorFichaTecnica(valor, prm);//validar con el parámetro
            else return null;
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    public int obtenerTotalFilas(String valor, String prm) throws Exception{
        try {
            if (!(prm.equals("")))
                return MaterialAD.Instancia().obtenerTotalFilas(valor, prm);
            else return 0;
        } catch (Exception e) {
            throw e;
        }        
    }
    
    public boolean registrarMaterial(Material objMaterial, String prm) throws Exception{
        try {
            if(objMaterial != null && !prm.equals("")){
                if(objMaterial.getObjProveedor().getIdproveedor() > 0 && !objMaterial.getObjProceso().getCodigoproceso().equals("") && !objMaterial.getObjFichaTecnica().getCodigoficha().equals(""))
                    return MaterialAD.Instancia().registrarMaterial(objMaterial, prm);
                else return false;
            }else return false;
            
        } catch (Exception e) {
            throw e;
        }
    }    
}
