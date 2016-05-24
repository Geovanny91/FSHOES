/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.ModeloAD;
import com.fshoes.entidades.Modelo;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class ModeloLN {

    // singleton
    public static ModeloLN _Instancia;
    private ModeloLN() {};
    public static ModeloLN Instancia() {
        if (_Instancia == null) {
            _Instancia = new ModeloLN();
        }
        return _Instancia;
    }
    // end Singleton

    public ArrayList<Modelo> listarModelos(String valor, String prm, int inicio, int fin) throws Exception {
        try {
            return ModeloAD.Instancia().listarModelos(valor, prm, inicio, fin);
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    public int obtenerTotalFilas(String valor, String prm) throws Exception{
        try {
            if (!(prm.equals("")))
                return ModeloAD.Instancia().obtenerTotalFilas(valor, prm);
            else return 0;
        } catch (Exception e) {
            throw e;
        }        
    }

    public boolean modificarModelo(Modelo objModelo, String prm) throws Exception {
        try {
            if (objModelo != null && !(prm.equals(""))) {
                if (!objModelo.getCodigomodelo().equals("") && objModelo.getObjcliente().getIdcliente() != 0)
                    return ModeloAD.Instancia().modificarModelo(objModelo, prm);
                else
                    return false;                
            }else
                return false;
        } catch (Exception e) {
            throw e;
        }
    }

    public boolean registrarModelo(Modelo objModelo, String prm) throws Exception {
        try {
            if (objModelo != null && !(prm.equals(""))) {
                if (!objModelo.getCodigomodelo().equals("") && objModelo.getObjcliente().getIdcliente() != 0)
                    return ModeloAD.Instancia().registrarModelo(objModelo, prm);
                else
                    return false;                
            }else
                return false;
        } catch (Exception e) {
            throw e;
        }
    }
    
}
