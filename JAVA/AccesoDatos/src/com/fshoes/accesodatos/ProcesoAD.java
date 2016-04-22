/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Proceso;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class ProcesoAD {
    // singleton
    public static ProcesoAD _Instancia;
	private ProcesoAD(){};
	public static ProcesoAD Instancia(){
		if(_Instancia==null){			
			_Instancia = new ProcesoAD();
		}
		return _Instancia;
	}
	// end Singleton
        
    public ArrayList<Proceso> listarProcesos() throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        ArrayList<Proceso> Lista = null;
        try{
            CallableStatement cst = cn.prepareCall("{call pa_proceso()}");
            ResultSet tabla = cst.executeQuery();
            Lista = new ArrayList<Proceso>();
            while(tabla.next()){
                Proceso p = new Proceso();
                p.setCodigoproceso(tabla.getString("codigoproceso"));
                p.setDescripcion(tabla.getString("descripcion"));                                
                Lista.add(p);
            }			
        }catch(Exception e){
                throw e;
        }finally{cn.close();}
        return Lista;
    }
        
}
