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
import java.sql.ResultSet;
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
        
    public ArrayList<Modelo> listarModelos(String valor, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        ArrayList<Modelo> Lista = null;
        try{
            CallableStatement cst = cn.prepareCall("{call pa_modelo(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);            
            cst.setString(2, prm);
            cst.setString(3, "");
            cst.setString(4, "");
            cst.setString(5, "");
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setString(9, "");
            cst.setInt(10, 0);
            cst.setBoolean(11, false);
            ResultSet tabla = cst.executeQuery();
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
        }finally{cn.close();}
        return Lista;
    }
    
    public boolean modificarModelo(Modelo objModelo, String prm) throws Exception{
        Connection cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            CallableStatement cst = cn.prepareCall("{call pa_modelo(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setString(3, objModelo.getCodigomodelo());
            cst.setString(4, "");
            cst.setString(5, objModelo.getHorma());
            cst.setString(6, objModelo.getTaco());
            cst.setString(7, objModelo.getPlataforma());
            cst.setString(8, objModelo.getColeccion());
            cst.setString(9, objModelo.getEspecificacion());
            cst.setInt(10, objModelo.getObjcliente().getIdcliente());            
            cst.setBoolean(11, objModelo.isEstado());
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
