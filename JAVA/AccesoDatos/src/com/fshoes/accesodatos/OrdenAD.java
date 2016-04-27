/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

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
            CallableStatement cst = cn.prepareCall("{call pa_orden(?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setString(3, objOrden.getCodigoorden());
            cst.setString(4, objOrden.getOrden_pedido());
            cst.setDate(5, (Date) objOrden.getFecha_emision());
            cst.setDate(6, (Date) objOrden.getFecha_entrega());
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
