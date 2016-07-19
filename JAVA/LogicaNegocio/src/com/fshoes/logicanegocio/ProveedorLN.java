/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.ProveedorAD;
import com.fshoes.entidades.Proveedor;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class ProveedorLN {
    // singleton
    public static ProveedorLN _Instancia;
	private ProveedorLN(){};
	public static ProveedorLN Instancia(){
            if(_Instancia==null){			
                    _Instancia = new ProveedorLN();
            }
            return _Instancia;
    }
    // end Singleton
        
    public ArrayList<Proveedor> listarProveedores(String valor, String prm, int inicio, int fin) throws Exception{
        try{
            if(!prm.equals(""))  
                return ProveedorAD.Instancia().listarProveedores(valor, prm, inicio, fin);
            else return null;
        }catch(Exception ex){
            throw ex;
        } 
    }
    
    public ArrayList<Proveedor> listarProveedores(String valor, String prm) throws Exception{
        try{
            return ProveedorAD.Instancia().listarProveedores(valor, prm);
        }catch(Exception ex){
            throw ex;
        }        
    }
    
    public boolean registrarCliente(Proveedor objProveedor, String prm) throws Exception{
        try {            
            if(objProveedor != null && !(prm.equals(""))){
                return ProveedorAD.Instancia().registrarProveedor(objProveedor, prm);
            }else{
                return false;
            }            
        } catch (Exception e) {
            throw e;
        }
    }
    
    public int obtenerTotalFilas(String valor, String prm) throws Exception{
        try {
            if (!(prm.equals("")))
                return ProveedorAD.Instancia().obtenerTotalFilas(valor, prm);
            else return 0;
        } catch (Exception e) {
            throw e;
        }        
    }
    
    public int existeProveedor(String valor, String prm) throws Exception{
        try {
            if (!(prm.equals("")) && !valor.equals(""))
                return ProveedorAD.Instancia().existeProveedor(valor, prm);
            else return 0;
        } catch (Exception e) {
            throw e;
        }        
    }
}
