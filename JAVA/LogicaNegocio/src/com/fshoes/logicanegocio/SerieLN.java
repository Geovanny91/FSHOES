/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.SerieAD;
import com.fshoes.entidades.Serie;

/**
 *
 * @author flores
 */
public class SerieLN {
    // singleton
    public static SerieLN _Instancia;
	private SerieLN(){};
	public static SerieLN Instancia(){
		if(_Instancia==null){			
			_Instancia = new SerieLN();
		}
		return _Instancia;
    }
    // end Singleton
        
    public boolean registrarSerie(Serie objSerie, String prm) throws Exception{
        try {            
            if(objSerie != null && !(prm.equals(""))){
                return SerieAD.Instancia().registrarSerie(objSerie, prm);
            }else{
                return false;
            }            
        } catch (Exception e) {
            throw e;
        }
    }
}
