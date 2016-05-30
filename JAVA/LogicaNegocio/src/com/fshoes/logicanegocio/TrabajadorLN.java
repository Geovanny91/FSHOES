/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.TrabajadorAD;
import com.fshoes.entidades.Trabajador;
import java.util.ArrayList;

/**
 *
 * @author Geovanny Rìos Abarca
 */
public class TrabajadorLN {
    //Singleton
    public static TrabajadorLN _Instancia;
    private TrabajadorLN(){};
    public static TrabajadorLN Instancia(){
        if(_Instancia==null){			
                _Instancia = new TrabajadorLN();
        }
        return _Instancia;
    }
    // end Singleton

    //Metodos
    public Trabajador lfVerificarAcceso(String usuario, String contrasena) 
                    throws Exception{
        try{
                return TrabajadorAD.Instancia().verificarAcceso(usuario, contrasena); 
        }catch(Exception ex){
                throw ex;
        }
    }
    
    public ArrayList<Trabajador> listarTrabajadores(String valor, String prm) throws Exception{
        try {
            if(!prm.equals("") && !valor.equals(""))            
                return TrabajadorAD.Instancia().listarTrabajadores(valor, prm);
            return null;
        } catch (Exception e) {
            throw e;
        }
    }
    
    public boolean registrarTrabajador(Trabajador objtrabajador, String prm) throws Exception{
        try {            
            if(objtrabajador != null && !(prm.equals(""))){
                if(!objtrabajador.getDni().equals(""))
                    return TrabajadorAD.Instancia().registrarTrabajador(objtrabajador, prm);
                else return false;
            }else{
                return false;
            } 
        } catch (Exception e) {
            throw e;
        }
    }
    
}
