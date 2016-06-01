/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.DetalleOrden;
import com.fshoes.entidades.Orden;
import com.fshoes.entidades.Proceso;
import com.fshoes.entidades.Trabajador;
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
public class DetalleOrdenAD {
    
    // Singleton
    public static DetalleOrdenAD _Instancia;
    private DetalleOrdenAD(){};
    public static DetalleOrdenAD Instancia(){
            if(_Instancia==null){			
                    _Instancia = new DetalleOrdenAD();
            }
            return _Instancia;
    }
    // fin Singleton
    
    private Connection cn = null;
    private CallableStatement cst = null;
    private PreparedStatement pst = null;
    private ResultSet tabla = null;   
    
    public boolean asignarOrden(DetalleOrden objDetalleOrden, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            cst = cn.prepareCall("{call pa_detalle_orden(?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setString(3, objDetalleOrden.getObjOrden().getCodigoorden());
            cst.setInt(4, objDetalleOrden.getObjTrabajador().getIdempleado());
            cst.setBoolean(5, objDetalleOrden.isEstado());
            cst.execute();
            rpt = true;
        } catch (Exception e) {
            throw e;
        }finally{
            close();
        }
        return rpt;
    }
    
    public boolean terminarProcesoOrden(DetalleOrden objDetalleOrden, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {//aquí se actuliza el estado del detalle orden, para indicar que se ha terminado un proceso
            cst = cn.prepareCall("{call pa_detalle_orden(?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setString(3, objDetalleOrden.getObjOrden().getCodigoorden());
            cst.setInt(4, 0);
            cst.setBoolean(5, objDetalleOrden.isEstado());
            cst.execute();
            rpt = true;
        } catch (Exception e) {
            throw e;
        }finally{
            close();
        }
        return rpt;
    }
    
    public ArrayList<DetalleOrden> listarDetalleOrden(String valor, String prm) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<DetalleOrden> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_detalle_orden(?,?,?,?,?)}");
            cst.setString(1, valor);            
            cst.setString(2, prm);
            cst.setString(3, "");
            cst.setString(4, "");
            cst.setString(5, "");            
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while(tabla.next()){
                DetalleOrden det = new DetalleOrden();
                Orden objOrden = new Orden();
                objOrden.setCodigoorden(tabla.getString("codigoorden"));
                det.setObjOrden(objOrden);
                Trabajador objTrabajador = new Trabajador();
                objTrabajador.setIdempleado(tabla.getInt("idempleado"));
                objTrabajador.setNombres(tabla.getString("nombres"));
                objTrabajador.setApe_paterno(tabla.getString("ape_paterno"));
                objTrabajador.setApe_materno(tabla.getString("ape_materno"));
                Proceso objProceso = new Proceso();
                objProceso.setCodigoproceso(tabla.getString("codigoproceso"));
                objProceso.setDescripcion(tabla.getString("descripcion"));
                objTrabajador.setCodigoproceso(objProceso);
                det.setObjTrabajador(objTrabajador);
                det.setEstado(tabla.getBoolean("estado"));                
                Lista.add(det);
            }			
        }catch(Exception e){
                throw e;
        }finally{close();}
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
