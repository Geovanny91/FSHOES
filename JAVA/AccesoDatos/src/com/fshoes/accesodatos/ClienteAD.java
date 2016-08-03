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
import java.sql.SQLException;
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
    
    private Connection cn = null;
    private CallableStatement cst = null;
    private ResultSet tabla = null;
        
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
        }finally{close();}
        return Lista;
    }
    
    public ArrayList<Cliente> listarClientesPaginacion(String valor, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<Cliente> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_cliente(?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setBoolean(8, false);
            
            tabla = cst.executeQuery();
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
        }finally{close();}
        return Lista;
    }
    
    public boolean registrarCliente(Cliente objCliente, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            cst = cn.prepareCall("{call pa_cliente(?,?,?,?,?,?,?,?)}");
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
           close();
        }
        return rpt;
    }
    
    public boolean modificarCliente(Cliente objCliente, String prm) throws Exception {
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            //enviar el id del cliente para la consulta o poner en el valor primer parámetro
            cst = cn.prepareCall("{call pa_cliente(?,?,?,?,?,?,?,?)}");
            cst.setString(1, String.valueOf(objCliente.getIdcliente()));//enviando el idcliente
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
        } finally {
            close();
        }
        return rpt;
    }
    
    public int obtenerTotalFilas(String valor, String prm) throws Exception{
        int total = 0;
        cn = Conexion.Instancia().getConexion();
        try {
            cst = cn.prepareCall("{call pa_cliente(?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setBoolean(8, false);
            tabla = cst.executeQuery();
            while(tabla.next()){
                total = tabla.getInt("total");
            }            
            return total;
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
            close();
        }       
        return total;        
    }
    
    public int existeCliente(String valor, String prm) throws Exception{
        int existe = 0;
        cn = Conexion.Instancia().getConexion();
        try {
            cst = cn.prepareCall("{call pa_cliente(?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setBoolean(8, false);
            tabla = cst.executeQuery();
            while(tabla.next()){
                existe = tabla.getInt("existe");
            }            
            return existe;
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
            close();
        }       
        return existe;        
    }
    
    private void close() {
        try {
          if (tabla != null) {
            tabla.close();
          }
          if (cst != null) {
            cst.close();
          }          
          if (cn != null) {
            cn.close();
          }
        } catch (SQLException e) {
            e.getMessage();
        }
  }
    
    
}
