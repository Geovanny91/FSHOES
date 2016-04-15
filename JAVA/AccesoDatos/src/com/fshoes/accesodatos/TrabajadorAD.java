/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Proceso;
import com.fshoes.entidades.Trabajador;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author Geovanny Rìos Abarca
 */
public class TrabajadorAD {
    public static TrabajadorAD _Instancia;
	private TrabajadorAD(){};
	public static TrabajadorAD Instancia(){
		if(_Instancia==null){			
			_Instancia = new TrabajadorAD();
		}
		return _Instancia;
	}
	// end Singleton
	
    public Trabajador verificarAcceso(String _User, String _Password) 
                    throws Exception{
            Connection cn = Conexion.Instancia().getConexion();
            Trabajador t = null;
            try{
                    CallableStatement cst = cn.prepareCall("{call verificar_acceso(?,?)}");
                    cst.setString(1, _User);
                    cst.setString(2, _Password);
                                     ResultSet rs = cst.executeQuery();
                    if(rs.next()){
                            t = new Trabajador();
                            t.setUsuario(rs.getString("usuario"));
                            t.setContrasena(rs.getString("contrasena"));
                            t.setNombres(rs.getString("nombres"));
                            t.setApe_paterno(rs.getString("ape_paterno"));
                            t.setApe_materno(rs.getString("ape_materno"));
                            Proceso p = new Proceso();
                                    p.setCodigoproceso(rs.getString("codigoproceso"));
                                    p.setDescripccion(rs.getString("descripcion"));
                                    //p.setIdmateriales(rs.getInt("idmateriales"));					
                                t.setCodigoproceso(p);
                    }			
            }catch(Exception e){
                    throw e;
            }finally{cn.close();}
            return t;
    }
}
