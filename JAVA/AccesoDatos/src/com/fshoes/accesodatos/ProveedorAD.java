/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Proveedor;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class ProveedorAD {
    // singleton
    public static ProveedorAD _Instancia;
	private ProveedorAD(){};
	public static ProveedorAD Instancia(){
		if(_Instancia==null){			
			_Instancia = new ProveedorAD();
		}
		return _Instancia;
	}
	// end Singleton
        
    public ArrayList<Proveedor> listarProveedores(String valor, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        ArrayList<Proveedor> Lista = null;
        try{
            CallableStatement cst = cn.prepareCall("{call pa_proveedor(?,?,?,?,?,?)}");
            cst.setString(1, valor);            
            cst.setString(2, prm);
            cst.setString(3, "");
            cst.setString(4, "");
            cst.setString(5, "");
            cst.setBoolean(6, false);
            ResultSet tabla = cst.executeQuery();
            Lista = new ArrayList<Proveedor>();
            while(tabla.next()){
                Proveedor c = new Proveedor();
                c.setIdproveedor(tabla.getInt("idproveedor"));
                c.setRazonsocial(tabla.getString("razonsocial"));
                c.setRuc(tabla.getString("ruc"));
                c.setDireccion(tabla.getString("direccion"));
                Lista.add(c);
            }			
        }catch(Exception e){
                throw e;
        }finally{cn.close();}
        return Lista;
    }
    
    public boolean registrarProveedor(Proveedor objProveedor, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            CallableStatement cst = cn.prepareCall("{call pa_proveedor(?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setString(3, objProveedor.getRazonsocial());
            cst.setString(4, objProveedor.getRuc());
            cst.setString(5, objProveedor.getDireccion());
            cst.setBoolean(6, objProveedor.isEstado());
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
