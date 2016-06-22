/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.ClienteAD;
import com.fshoes.entidades.Cliente;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class ClienteLN {
    // singleton
    public static ClienteLN _Instancia;
	private ClienteLN(){};
	public static ClienteLN Instancia(){
            if(_Instancia==null){			
                    _Instancia = new ClienteLN();
            }
            return _Instancia;
    }
    // end Singleton
    
    public ArrayList<Cliente> listarClientes(String valor, String prm, int inicio, int fin) throws Exception{
        try{
            if(!prm.equals(""))  
                return ClienteAD.Instancia().listarClientes(valor, prm, inicio, fin);
            else return null;
        }catch(Exception ex){
            throw ex;
        }        
    }
        
    public ArrayList<Cliente> listarClientes(String valor, String prm) throws Exception{
        try{
            if(!prm.equals(""))  
                return ClienteAD.Instancia().listarClientes(valor, prm);
            else return null;
        }catch(Exception ex){
            throw ex;
        }        
    }
    
    public boolean registrarCliente(Cliente objCliente, String prm) throws Exception{
        try {            
            if(objCliente != null && !(prm.equals(""))){
                return ClienteAD.Instancia().registrarCliente(objCliente, prm);
            }else{
                return false;
            }            
        } catch (Exception e) {
            throw e;
        }
    }
}
