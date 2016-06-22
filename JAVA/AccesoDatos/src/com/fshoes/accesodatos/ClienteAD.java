/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Cliente;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class ClienteAD {
    // singleton
    public static ClienteAD _Instancia;
	private ClienteAD(){};
	public static ClienteAD Instancia(){
		if(_Instancia==null){			
			_Instancia = new ClienteAD();
		}
		return _Instancia;
	}
	// end Singleton
        
    public ArrayList<Cliente> listarClientes(String valor, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        ArrayList<Cliente> Lista = null;
        try{
            CallableStatement cst = cn.prepareCall("{call pa_cliente(?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setBoolean(8, false);
            
            ResultSet tabla = cst.executeQuery();
            Lista = new ArrayList<Cliente>();
            while(tabla.next()){
                Cliente c = new Cliente();
                c.setIdcliente(tabla.getInt("idcliente"));
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
    
    public ArrayList<Cliente> listarClientes(String valor, String prm, int inicio, int fin) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        ArrayList<Cliente> Lista = null;
        try{
            CallableStatement cst = cn.prepareCall("{call pa_cliente(?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, inicio);
            cst.setInt(4, fin);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setBoolean(8, false);
            
            ResultSet tabla = cst.executeQuery();
            Lista = new ArrayList<Cliente>();
            while(tabla.next()){
                Cliente c = new Cliente();
                c.setIdcliente(tabla.getInt("idcliente"));
                c.setRazonsocial(tabla.getString("razonsocial"));
                c.setRuc(tabla.getString("ruc"));
                c.setDireccion(tabla.getString("direccion"));
                c.setEstado(tabla.getBoolean("estado"));
                Lista.add(c);
            }			
        }catch(Exception e){
                throw e;
        }finally{cn.close();}
        return Lista;
    }
    
    public boolean registrarCliente(Cliente objCliente, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            CallableStatement cst = cn.prepareCall("{call pa_cliente(?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, objCliente.getRazonsocial());
            cst.setString(6, objCliente.getRuc());
            cst.setString(7, objCliente.getDireccion());
            cst.setBoolean(8, objCliente.isEstado());
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
