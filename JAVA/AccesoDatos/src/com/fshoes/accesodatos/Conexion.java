/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.accesodatos;

import java.sql.Connection;
import java.sql.DriverManager;
/**
 *
 * @author Geovanny Rìos Abarca
 */
public class Conexion {
    
    //Singleton
	public static Conexion _Instancia;
	private Conexion(){};
	public static Conexion Instancia(){
		if(_Instancia==null){			
			_Instancia = new Conexion();
		}
		return _Instancia;
	}
	// end Singleton
	
	public Connection getConexion() throws Exception{
		Connection cn = null;
		try{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			cn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;"+
						"databaseName=fshoes", "sa", "123456");
		}catch(Exception e){
			throw e;
		}
		return cn;
	}
    
    
    /*public static void main(String[] args) {
        
            try {
                Conexion cn = new Conexion();
                System.out.println(cn.getConexion());
            } catch (Exception ex) {
                System.out.println("ERROR: " + ex.getMessage());
            }
    }*/
}
