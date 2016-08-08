/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Cliente;
import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Modelo;
import com.fshoes.entidades.Orden;
import com.fshoes.entidades.Serie;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class OrdenAD {
    public static OrdenAD _Instancia;
        private OrdenAD(){};
        public static OrdenAD Instancia(){
                if(_Instancia==null){			
                        _Instancia = new OrdenAD();
                }
                return _Instancia;
        }
	// end Singleton
    
    private Connection cn = null;
    private CallableStatement cst = null;
    private PreparedStatement pst = null;
    private ResultSet tabla = null;
        
    public ArrayList<Orden> listarOrdenesTerminadas(String valor, String prm, Orden orden) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<Orden> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_orden(?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setDate(7, (Date) orden.getFecha_emision());
            cst.setDate(8, (Date) orden.getFecha_entrega());
            cst.setInt(9, 0);
            cst.setString(10, "");
            
            cst.execute();
            
            tabla = cst.executeQuery();
            Lista = new ArrayList<Orden>();
            while(tabla.next()){
                Orden o = new Orden();
                o.setCodigoorden(tabla.getString("codigoorden"));
                o.setOrden_pedido(tabla.getString("orden_pedido"));
                o.setFecha_entrega(tabla.getDate("fecha_entrega"));
                FichaTecnica ficha = new FichaTecnica();
                ficha.setCodigoficha(tabla.getString("codigoficha"));
                ficha.setColor(tabla.getString("color"));
                Modelo modelo = new Modelo();
                modelo.setCodigomodelo(tabla.getString("codigomodelo"));                
                ficha.setObjModelo(modelo);
                o.setObjFicha(ficha);
                o.setTotal(tabla.getInt("total"));
                Lista.add(o);
            }			
        }catch(Exception e){
                throw e;
        }finally{close();}
        return Lista;
    }
    
    public boolean registrarOrden(Orden objOrden, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            cst = cn.prepareCall("{call pa_orden(?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);            
            cst.setString(5, objOrden.getCodigoorden());
            cst.setString(6, objOrden.getOrden_pedido());
            cst.setDate(7, (Date) objOrden.getFecha_emision());
            cst.setDate(8, (Date) objOrden.getFecha_entrega());
            cst.setInt(9, objOrden.getTotal());
            cst.setString(10, objOrden.getObjFicha().getCodigoficha());
            cst.execute();
            rpt = true;
        } catch (Exception e) {
            throw e;
        }finally{
            close();
        }
        return rpt;
    }
    
    public ArrayList<Orden> listarCaberaOrden(String valor, String prm) throws Exception {
        cn = Conexion.Instancia().getConexion();
        ArrayList<Orden> Lista = null;
        try {
            cst = cn.prepareCall("{call pa_orden(?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setInt(9, 0);
            cst.setString(10, "");
            
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while (tabla.next()) {
                
                Cliente cliente = new Cliente();
                cliente.setRazonsocial(tabla.getString("razonsocial"));
                
                
                Modelo modelo = new Modelo();
                modelo.setCodigomodelo(tabla.getString("codigomodelo"));
                modelo.setHorma(tabla.getString("horma"));
                modelo.setEspecificacion(tabla.getString("especificacion"));
                modelo.setObjcliente(cliente);
                
                FichaTecnica ficha = new FichaTecnica();
                ficha.setCodigoficha(tabla.getString("codigoficha"));
                ficha.setPlataforma(tabla.getString("plataforma"));
                ficha.setTaco(tabla.getString("taco"));
                ficha.setColor(tabla.getString("color"));
                ficha.setUrlimagen(tabla.getString("urlimagen"));
                ficha.setObjModelo(modelo);
                
                Orden orden = new Orden();
                orden.setCodigoorden(tabla.getString("codigoorden"));
                orden.setOrden_pedido(tabla.getString("orden_pedido"));
                orden.setFecha_emision(tabla.getDate("fecha_emision"));
                orden.setFecha_entrega(tabla.getDate("fecha_entrega"));
                orden.setTotal(tabla.getInt("total"));
                orden.setObjFicha(ficha);
                
               /*Serie s = new Serie();
                s.setTallas(tabla.getInt("tallas"));
                s.setPares(tabla.getInt("pares"));
                s.setCodigoorden(orden);    */            
                
                Lista.add(orden);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }
        return Lista;
    }
    
    public int obtenerTotalFilas(String valor, String prm, Orden objOrden) throws Exception{
        int total = 0;
        cn = Conexion.Instancia().getConexion();
        try {
            cst = cn.prepareCall("{call pa_orden(?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setDate(7, (Date) objOrden.getFecha_emision());
            cst.setDate(8, (Date) objOrden.getFecha_entrega());
            cst.setInt(9, 0);
            cst.setString(10, "");
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
    
    public int existeOrden(String valor, String prm) throws Exception{
        int existe = 0;
        cn = Conexion.Instancia().getConexion();
        try {
            cst = cn.prepareCall("{call pa_orden(?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setInt(9, 0);
            cst.setString(10, "");
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
