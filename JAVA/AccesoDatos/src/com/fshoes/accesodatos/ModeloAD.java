/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Cliente;
import com.fshoes.entidades.Modelo;
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
public class ModeloAD {
    // singleton
    public static ModeloAD _Instancia;
	private ModeloAD(){};
	public static ModeloAD Instancia(){
		if(_Instancia==null){			
			_Instancia = new ModeloAD();
		}
		return _Instancia;
	}
	// end Singleton
    
    private Connection cn = null;
    private CallableStatement cst = null;
    private PreparedStatement pst = null;
    private ResultSet tabla = null;    
        
    public ArrayList<Modelo> listarModelos(String valor, String prm, int inicio, int fin) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<Modelo> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_modelo(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);            
            cst.setString(2, prm);
            cst.setInt(3, inicio);
            cst.setInt(4, fin);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setString(9, "");
            cst.setString(10, "");
            cst.setString(11, "");
            cst.setInt(12, 0);
            cst.setBoolean(13, false);
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while(tabla.next()){
                Modelo m = new Modelo();
                m.setCodigomodelo(tabla.getString("codigomodelo"));
                m.setUrlimagen(tabla.getString("urlimagen"));
                m.setHorma(tabla.getString("horma"));
                m.setTaco(tabla.getString("taco"));
                m.setPlataforma(tabla.getString("plataforma"));
                m.setColeccion(tabla.getString("coleccion"));
                m.setEspecificacion(tabla.getString("especificacion"));
                Cliente objcliente = new Cliente();
                objcliente.setIdcliente(tabla.getInt("idcliente"));
                objcliente.setRazonsocial(tabla.getString("razonsocial"));
                m.setObjcliente(objcliente);
                m.setEstado(tabla.getBoolean("estado"));
                Lista.add(m);
            }			
        }catch(Exception e){
                throw e;
        }finally{close();}
        return Lista;
    }
    
    public ArrayList<Modelo> listarModelos(String valor, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<Modelo> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_modelo(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);            
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setString(9, "");
            cst.setString(10, "");
            cst.setString(11, "");
            cst.setInt(12, 0);
            cst.setBoolean(13, false);
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while(tabla.next()){
                Modelo m = new Modelo();
                m.setCodigomodelo(tabla.getString("codigomodelo"));
                m.setHorma(tabla.getString("horma"));
                m.setTaco(tabla.getString("taco"));
                m.setPlataforma(tabla.getString("plataforma"));
                m.setColeccion(tabla.getString("coleccion"));                
                Cliente objcliente = new Cliente();
                objcliente.setIdcliente(tabla.getInt("idcliente"));
                objcliente.setRazonsocial(tabla.getString("razonsocial"));
                m.setObjcliente(objcliente);                
                Lista.add(m);
            }
        }catch(Exception e){
                throw e;
        }finally{ close();}
        return Lista;
    }
    
    public int obtenerTotalFilas(String valor, String prm) throws Exception{
        int total = 0;
        cn = Conexion.Instancia().getConexion();
        try {
            cst = cn.prepareCall("{call pa_modelo(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);            
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setString(9, "");
            cst.setString(10, "");
            cst.setString(11, "");
            cst.setInt(12, 0);
            cst.setBoolean(13, false);
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
    
    public boolean modificarModelo(Modelo objModelo, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            cst = cn.prepareCall("{call pa_modelo(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, objModelo.getCodigomodelo());
            cst.setString(6, "");
            cst.setString(7, objModelo.getHorma());
            cst.setString(8, objModelo.getTaco());
            cst.setString(9, objModelo.getPlataforma());
            cst.setString(10, objModelo.getColeccion());
            cst.setString(11, objModelo.getEspecificacion());
            cst.setInt(12, objModelo.getObjcliente().getIdcliente());            
            cst.setBoolean(13, objModelo.isEstado());
            cst.execute();
            rpt = true;
        } catch (Exception e) {
            throw e;
        }finally{
            close();
        }
        return rpt;
    }
    
    public boolean registrarModelo(Modelo objModelo, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            cst = cn.prepareCall("{call pa_modelo(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, objModelo.getCodigomodelo());
            cst.setString(6, "");
            cst.setString(7, objModelo.getHorma());
            cst.setString(8, objModelo.getTaco());
            cst.setString(9, objModelo.getPlataforma());
            cst.setString(10, objModelo.getColeccion());
            cst.setString(11, objModelo.getEspecificacion());
            cst.setInt(12, objModelo.getObjcliente().getIdcliente());            
            cst.setBoolean(13, objModelo.isEstado());
            cst.execute();
            rpt = true;            
        } catch (Exception e) {
            throw e;
        }finally{
            close();
        }
        return rpt;
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
