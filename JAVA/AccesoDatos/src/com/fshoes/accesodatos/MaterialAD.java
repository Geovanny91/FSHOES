/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Material;
import com.fshoes.entidades.Proceso;
import com.fshoes.entidades.Proveedor;
import com.sun.org.apache.bcel.internal.generic.AALOAD;
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

    private MaterialAD() {
    }

    ;
	public static MaterialAD Instancia() {
        if (_Instancia == null) {
            _Instancia = new MaterialAD();
        }
        return _Instancia;
    }
    // end Singleton

    private Connection cn = null;
    private CallableStatement cst = null;
    private PreparedStatement pst = null;
    private ResultSet tabla = null;

    public ArrayList<Material> listarMaterial(String valor, String prm, int inicio, int fin) throws Exception {
        cn = Conexion.Instancia().getConexion();
        ArrayList<Material> Lista = null;
        try {
            cst = cn.prepareCall("{call pa_material(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
            cst.setInt(12, 0);
            cst.setString(13, "");
            cst.setString(14, "");
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while (tabla.next()) {
                Material m = new Material();
                m.setIdmaterial(tabla.getInt("idmaterial"));
                m.setNombre(tabla.getString("nombre"));
                m.setDescripcion(tabla.getString("descripcion"));
                m.setUnidadmedida(tabla.getString("unidadmedida"));
                m.setCantidaddocena(tabla.getFloat("cantidaddocena"));
                m.setPreciounitario(tabla.getFloat("preciounitario"));
                m.setTipo(tabla.getString("tipo"));
                Proveedor p = new Proveedor();
                p.setIdproveedor(tabla.getInt("idproveedor"));
                p.setRazonsocial(tabla.getString("razonsocial"));
                m.setObjProveedor(p);
                Proceso proceso = new Proceso();
                proceso.setCodigoproceso(tabla.getString("codigoproceso"));
                proceso.setDescripcion(tabla.getString("procDescripcion"));
                m.setObjProceso(proceso);
                FichaTecnica ficha = new FichaTecnica();
                ficha.setCodigoficha(tabla.getString("codigoficha"));
                m.setObjFichaTecnica(ficha);
                Lista.add(m);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }
        return Lista;
    }

    public ArrayList<Material> obtenerMaterialesPorFichaTecnica(String valor, String prm) throws Exception {
        cn = Conexion.Instancia().getConexion();
        ArrayList<Material> Lista = null;
        try {
            cst = cn.prepareCall("{call pa_material(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
            cst.setInt(12, 0);
            cst.setString(13, "");
            cst.setString(14, "");
            tabla = cst.executeQuery();
            Lista = new ArrayList<>();
            while (tabla.next()) {
                Material m = new Material();
                m.setIdmaterial(tabla.getInt("idmaterial"));
                m.setNombre(tabla.getString("nombre"));
                m.setDescripcion(tabla.getString("descripcion"));
                m.setUnidadmedida(tabla.getString("unidadmedida"));
                m.setCantidaddocena(tabla.getFloat("cantidaddocena"));
                m.setPreciounitario(tabla.getFloat("preciounitario"));
                m.setTipo(tabla.getString("tipo"));
                Proveedor proveedor = new Proveedor();
                proveedor.setIdproveedor(tabla.getInt("idproveedor"));
                m.setObjProveedor(proveedor);
                Proceso proceso = new Proceso();
                proceso.setCodigoproceso(tabla.getString("codigoproceso"));
                proceso.setDescripcion(tabla.getString("proceso_descripcion"));
                m.setObjProceso(proceso);
                FichaTecnica objFichaTecnica = new FichaTecnica();
                objFichaTecnica.setCodigoficha(tabla.getString("codigoficha"));
                m.setObjFichaTecnica(objFichaTecnica);
                Lista.add(m);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }
        return Lista;
    }
    
    public boolean registrarMaterial(Material objMaterial, String prm) throws Exception {
        cn = Conexion.Instancia().getConexion();
        boolean rpt = false;
        try {
            cst = cn.prepareCall("{call pa_material(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setString(1, "");
            cst.setString(2, prm);
            cst.setInt(3, 0);
            cst.setInt(4, 0);
            cst.setInt(5, objMaterial.getIdmaterial());
            cst.setString(6, objMaterial.getNombre());
            cst.setString(7, objMaterial.getDescripcion());
            cst.setString(8, objMaterial.getUnidadmedida());
            cst.setFloat(9, objMaterial.getCantidaddocena());
            cst.setFloat(10, objMaterial.getPreciounitario());
            cst.setString(11, objMaterial.getTipo());
            cst.setInt(12, objMaterial.getObjProveedor().getIdproveedor());
            cst.setString(13, objMaterial.getObjProceso().getCodigoproceso());
            cst.setString(14, objMaterial.getObjFichaTecnica().getCodigoficha());
            cst.execute();
            rpt = true;
        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }
        return rpt;
    }

    public int obtenerTotalFilas(String valor, String prm) throws Exception {
        int total = 0;
        cn = Conexion.Instancia().getConexion();
        try {
            cst = cn.prepareCall("{call pa_material(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
            cst.setInt(12, 0);
            cst.setString(13, "");
            cst.setString(14, "");
            tabla = cst.executeQuery();
            while (tabla.next()) {
                total = tabla.getInt("total");
            }
            return total;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
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
