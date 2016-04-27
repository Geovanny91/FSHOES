/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Orden;
import com.fshoes.entidades.Serie;
import java.sql.CallableStatement;
import java.sql.Connection;

/**
 *
 * @author flores
 */
public class SerieAD {
    // singleton
    public static SerieAD _Instancia;
	private SerieAD(){};
	public static SerieAD Instancia(){
		if(_Instancia==null){			
			_Instancia = new SerieAD();
		}
		return _Instancia;
    }
    // end Singleton
    
    public boolean registrarSerie(Serie objserie, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            CallableStatement cst = cn.prepareCall("{call pa_serie(?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setInt(3, objserie.getTallas());
            cst.setInt(4, objserie.getPares());            
            cst.setString(5, objserie.getCodigoorden().getCodigoorden());            
            cst.execute();
            rpt = true;
        } catch (Exception e) {
            throw e;
        }finally{
            cn.close();            
        }
        return rpt;
    }
        
}
