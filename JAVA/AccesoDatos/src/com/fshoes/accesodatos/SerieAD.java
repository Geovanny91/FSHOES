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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
    
    private Connection cn = null;
    private CallableStatement cst = null;
    private PreparedStatement pst = null;
    private ResultSet tabla = null;
        
    public boolean registrarSerie(Serie objserie, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            cst = cn.prepareCall("{call pa_serie(?,?,?,?,?)}");
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
            close();            
        }
        return rpt;
    }
    
    public ArrayList<Serie> listarSeriePorOrden(String valor, String prm) throws Exception {
        cn = Conexion.Instancia().getConexion();
        ArrayList<Serie> Lista = null;
        try {
            cst = cn.prepareCall("{call pa_serie(?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");           
            
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while (tabla.next()) {
                                
                Serie serie = new Serie();
                serie.setTallas(tabla.getInt("tallas"));
                serie.setPares(tabla.getInt("pares"));                
                Lista.add(serie);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }
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
            if (pst != null) {
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
