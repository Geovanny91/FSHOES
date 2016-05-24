/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.Material;
import com.fshoes.entidades.Proveedor;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Geovanny
 */
public class MaterialAD {
    // singleton
    public static MaterialAD _Instancia;
	private MaterialAD(){};
	public static MaterialAD Instancia(){
		if(_Instancia==null){			
			_Instancia = new MaterialAD();
		}
		return _Instancia;
	}
	// end Singleton
    
    private Connection cn = null;
    private CallableStatement cst = null;
    private PreparedStatement pst = null;
    private ResultSet tabla = null; 
    
    public ArrayList<Material> listarMaterial(String valor, String prm, int inicio, int fin) throws Exception{
        cn = Conexion.Instancia().getConexion();
        ArrayList<Material> Lista = null;
        try{
            cst = cn.prepareCall("{call pa_material(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);            
            cst.setString(2, prm);
            cst.setInt(3, inicio);
            cst.setInt(4, fin);
            cst.setInt(5, 0);
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setInt(9, 0);
            cst.setFloat(10, 0);
            cst.setString(11, "");
            cst.setString(12, "");
            cst.setInt(13, 0);
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while(tabla.next()){
                Material m = new Material();
                m.setIdmaterial(tabla.getInt("idmaterial"));
                m.setNombre(tabla.getString("nombre"));
                m.setDescripcion(tabla.getString("descripcion"));
                m.setUnidadmedida(tabla.getString("unidadmedida"));
                m.setCantidaddocena(tabla.getInt("cantidaddocena"));
                m.setPreciounitario(tabla.getFloat("preciounitario"));
                //m.setTipo(tabla.getString("tipo"));
                //m.setColor(tabla.getString("color"));
                Proveedor p = new Proveedor();
                p.setIdproveedor(tabla.getInt("idproveedor"));
                p.setRazonsocial(tabla.getString("razonsocial"));
                m.setObjProveedor(p);
                Lista.add(m);
            }			
        }catch(Exception e){
                throw e;
        }finally{close();}
        return Lista;
    }
    
    public int obtenerTotalFilas(String valor, String prm) throws Exception{
        int total = 0;
        cn = Conexion.Instancia().getConexion();
        try {
            cst = cn.prepareCall("{call pa_material(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, valor);            
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setInt(5, 0);
            cst.setString(6, "");
            cst.setString(7, "");
            cst.setString(8, "");
            cst.setInt(9, 0);
            cst.setFloat(10, 0);
            cst.setString(11, "");
            cst.setString(12, "");
            cst.setInt(13, 0);
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
