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
	private ModeloLN(){};
	public static ModeloLN Instancia(){
            if(_Instancia==null){			
                    _Instancia = new ModeloLN();
            }
            return _Instancia;
    }
    // end Singleton
    
    public ArrayList<Modelo> listarModelos(String valor, String prm) throws Exception{
        try{
            return ModeloAD.Instancia().listarModelos(valor, prm);
        }catch(Exception ex){
            throw ex;
        }        
    }
    
    public boolean modificarModelo(Modelo objModelo, String prm) throws Exception{
        try {
            return ModeloAD.Instancia().modificarModelo(objModelo, prm);
        } catch (Exception e) {
            throw  e;
        }    
    }

}
