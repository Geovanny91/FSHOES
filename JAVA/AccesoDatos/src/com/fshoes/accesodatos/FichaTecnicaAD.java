/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Cliente;
import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Modelo;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class FichaTecnicaAD {

    // singleton
    public static FichaTecnicaAD _Instancia;

    private FichaTecnicaAD() {};
	public static FichaTecnicaAD Instancia() {
        if (_Instancia == null) {
            _Instancia = new FichaTecnicaAD();
        }
        return _Instancia;
    }
    // end Singleton
    private Connection cn = null;
    private CallableStatement cst = null;    
    private ResultSet tabla = null;

    public ArrayList<FichaTecnica> listarFichaTecnica(String valor, String prm, int inicio, int fin) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<FichaTecnica> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_ficha_tecnica(?,?,?,?,?,?,?,?,?,?,?)}");
            
            cst.setString(1, "");
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
            
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while(tabla.next()){
                Modelo objmodelo = new Modelo();
                objmodelo.setCodigomodelo(tabla.getString("codigomodelo"));               
                objmodelo.setHorma(tabla.getString("horma"));                
                //objmodelo.setEspecificacion(tabla.getString("especificacion"));
                Cliente objcliente = new Cliente();
                objcliente.setIdcliente(tabla.getInt("idcliente"));
                objcliente.setRazonsocial(tabla.getString("razonsocial"));                
                objmodelo.setObjcliente(objcliente);
                FichaTecnica objFicha = new FichaTecnica();
                objFicha.setCodigoficha(tabla.getString("codigoficha"));
                objFicha.setTaco(tabla.getString("taco"));
                objFicha.setPlataforma(tabla.getString("plataforma"));
                objFicha.setColor(tabla.getString("color"));
                objFicha.setColeccion(tabla.getString("coleccion"));   
                objFicha.setObjModelo(objmodelo);
                //objmodelo.setEstado(tabla.getBoolean("estado"));
                Lista.add(objFicha);                
            }			
        }catch(Exception e){
                throw e;
        }finally{close();}
        return Lista;
    }
    
    public ArrayList<FichaTecnica> listarFichaTecnica(String valor, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<FichaTecnica> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_ficha_tecnica(?,?,?,?,?,?,?,?,?,?,?)}");
            
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
            
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while(tabla.next()){
                Modelo objmodelo = new Modelo();
                objmodelo.setCodigomodelo(tabla.getString("codigomodelo"));               
                objmodelo.setHorma(tabla.getString("horma"));                
                //objmodelo.setEspecificacion(tabla.getString("especificacion"));
                Cliente objcliente = new Cliente();
                objcliente.setIdcliente(tabla.getInt("idcliente"));
                objcliente.setRazonsocial(tabla.getString("razonsocial"));                
                objmodelo.setObjcliente(objcliente);
                FichaTecnica objFicha = new FichaTecnica();
                objFicha.setCodigoficha(tabla.getString("codigoficha"));
                objFicha.setTaco(tabla.getString("taco"));
                objFicha.setPlataforma(tabla.getString("plataforma"));
                objFicha.setColor(tabla.getString("color"));
                objFicha.setColeccion(tabla.getString("coleccion"));   
                objFicha.setObjModelo(objmodelo);
                //objmodelo.setEstado(tabla.getBoolean("estado"));
                Lista.add(objFicha);   
            }
        }catch(Exception e){
                throw e;
        }finally{ close();}
        return Lista;
    }
    
    public boolean registrarFichaTecnica(FichaTecnica objFicha, String prm) throws Exception {
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            cst = cn.prepareCall("{call pa_ficha_tecnica(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, objFicha.getCodigoficha());
            cst.setString(6, objFicha.getPlataforma());
            cst.setString(7, objFicha.getTaco());
            cst.setString(8, objFicha.getColor());
            cst.setString(9, objFicha.getColeccion());
            cst.setString(10, objFicha.getUrlimagen());
            cst.setString(11, objFicha.getObjModelo().getCodigomodelo());
            cst.execute();
            rpt = true;
        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }
        return rpt;
    }

    public int existeFichaTecnica(String valor, String prm) throws Exception{
        int total = 0;
        cn = Conexion.Instancia().getConexion();
        try {
            cst = cn.prepareCall("{call pa_ficha_tecnica(?,?,?,?,?,?,?,?,?,?,?)}");
            
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
            
            tabla = cst.executeQuery();
            while(tabla.next()){
                total = tabla.getInt("existe");
            }            
            return total;
        } catch (Exception ex) {
            ex.printStackTrace();
        }finally{
            close();
        }       
        return total;        
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
