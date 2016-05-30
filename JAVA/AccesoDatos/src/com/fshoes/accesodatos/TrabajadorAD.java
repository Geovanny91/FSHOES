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
import java.util.ArrayList;

/**
 *
 * @author Geovanny Rìos Abarca
 */
public class TrabajadorAD {
    // singleton
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
                                    p.setDescripcion(rs.getString("descripcion"));
                                    //p.setIdmateriales(rs.getInt("idmateriales"));					
                                t.setCodigoproceso(p);
                    }			
            }catch(Exception e){
                    throw e;
            }finally{cn.close();}
            return t;
    }
    
    public ArrayList<Trabajador> listarTrabajadores(String valor, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        ArrayList<Trabajador> Lista = null;
        try{
            CallableStatement cst = cn.prepareCall("{call pa_trabajador(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);            
            cst.setString(3, "");
            cst.setString(4, "");
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setString(9, "");
            cst.setString(10, "");
            cst.setString(11, "");
            cst.setString(12, "");            
            cst.setBoolean(13, false);
            cst.setString(14, "");
            
            ResultSet tabla = cst.executeQuery();
            Lista = new ArrayList<Trabajador>();
            while(tabla.next()){
                Trabajador t = new Trabajador();                
                t.setNombres(tabla.getString("nombres"));
                t.setApe_paterno(tabla.getString("ape_paterno"));
                t.setApe_materno(tabla.getString("ape_materno"));
                Lista.add(t);
            }			
        }catch(Exception e){
                throw e;
        }finally{cn.close();}
        return Lista;
    }
    
    public boolean registrarTrabajador(Trabajador objTrabajador, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            CallableStatement cst = cn.prepareCall("{call pa_trabajador(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);            
            cst.setString(3, objTrabajador.getDni());
            cst.setString(4, objTrabajador.getNombres());
            cst.setString(5, objTrabajador.getApe_paterno());
            cst.setString(6, objTrabajador.getApe_materno());
            cst.setString(7, objTrabajador.getDireccion());
            cst.setString(8, objTrabajador.getTelefono());
            cst.setString(9, objTrabajador.getCelular());
            cst.setString(10, objTrabajador.getFecha_nacimiento());
            cst.setString(11, objTrabajador.getUsuario());
            cst.setString(12, objTrabajador.getContrasena());            
            cst.setBoolean(13, objTrabajador.isEstado());
            cst.setString(14, objTrabajador.getCodigoproceso().getCodigoproceso());
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
