/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Proceso;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    
    private Connection cn = null;
    private CallableStatement cst = null;
    private PreparedStatement pst = null;
    private ResultSet tabla = null;   
        
    public ArrayList<Proceso> listarProcesos(String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<Proceso> Lista = null;
        try{
            CallableStatement cst = cn.prepareCall("{call pa_proceso(?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);            
            tabla = cst.executeQuery();
            Lista = new ArrayList<Proceso>();
            while(tabla.next()){
                Proceso p = new Proceso();
                p.setCodigoproceso(tabla.getString("codigoproceso"));
                p.setDescripcion(tabla.getString("descripcion"));                                
                Lista.add(p);
            }			
        }catch(Exception e){
                throw e;
        }finally{ close();}
        return Lista;
    }
    
    public ArrayList<Proceso> listarProcesos(String valor, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<Proceso> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_proceso(?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);   
            tabla = cst.executeQuery();
            Lista = new ArrayList<Proceso>();
            while(tabla.next()){
                Proceso p = new Proceso();
                p.setCodigoproceso(tabla.getString("codigoproceso"));
                p.setDescripcion(tabla.getString("descripcion"));                                
                Lista.add(p);
            }			
        }catch(Exception e){
                throw e;
        }finally{ close();}
        return Lista;
    }
    
    private void close() {
        try {
          if (tabla != null) {
            tabla.close();
          }
          if (cst != null) {
            cst.close();
          }
          if(pst != null){
              pst.close();
          }
          if (cn != null) {
            cn.close();
          }
        } catch (SQLException e) {
            e.getMessage();
        }
  }
    
}
