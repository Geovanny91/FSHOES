/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Modelo;
import com.fshoes.entidades.Orden;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;

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
        
    public boolean registrarOrden(Orden objOrden, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            CallableStatement cst = cn.prepareCall("{call pa_orden(?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setString(3, objOrden.getCodigoorden());
            cst.setString(4, objOrden.getOrden_pedido());
            cst.setString(5, objOrden.getFecha_emision());
            cst.setString(6, objOrden.getFecha_entrega());
            cst.setDouble(7, objOrden.getTotal());
            cst.setString(8, objOrden.getObjModelo().getCodigomodelo());
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
