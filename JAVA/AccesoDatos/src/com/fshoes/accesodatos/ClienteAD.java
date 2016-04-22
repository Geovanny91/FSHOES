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
        
    public ArrayList<Cliente> listarClientes(String valor) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        ArrayList<Cliente> Lista = null;
        try{
            CallableStatement cst = cn.prepareCall("{call pa_cliente(?)}");
            cst.setString(1, valor);
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
}
