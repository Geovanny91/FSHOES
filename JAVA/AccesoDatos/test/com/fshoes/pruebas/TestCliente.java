/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.pruebas;

import com.fshoes.accesodatos.ClienteAD;
import com.fshoes.entidades.Cliente;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.junit.Assert;

import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Before;


/**
 *
 * @author Flores
 */
public class TestCliente {
    
    private static ClienteAD dao;
    private static ArrayList<Cliente> lstCliente;
    
    @Before
    public void beforeClass(){        
        lstCliente = new ArrayList<Cliente>();        
    }
    
    @Test
    public void listarCliente(){
        try {
            System.out.println("TEST LISTAR CLIENTE");
            lstCliente = ClienteAD.Instancia().listarClientes("", "listarCliente");
            int actual = lstCliente.size();
            int esperado = 5;
            assertEquals(esperado, actual);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    @Test
    public void listarClientePaginacion(){
        try {
            System.out.println("TEST LISTAR CLIENTE PAGINACIÓN");
            int inicio = 0, fin = 3;
            lstCliente = ClienteAD.Instancia().listarClientes("", "listarClientePaginacion", inicio, fin);
            int actual = lstCliente.size();
            int esperado = 3;
            assertEquals("El número de clientes esperado es: ",esperado, actual);
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    @Test
    public void listar(){        
        Cliente c1 = new Cliente(1, "ABC", "10203645854", "Urb. Palermo #45", true);
        Cliente c2 = new Cliente(2, "JDK", "10859612745", "Urb. Rinconada #45", true);
        
        ArrayList<Cliente> lstCliente_esperado = new ArrayList<>();
        lstCliente_esperado.add(c1);
        lstCliente_esperado.add(c2);
        
        Cliente c3 = c1;
        Cliente c4 = c2;
        Cliente c5 = new Cliente(3, "JDK", "10859612745", "Urb. Rinconada #45", true);
        
        ArrayList<Cliente> lstCliente_actual = new ArrayList<>();
        lstCliente_actual.add(c3);
        lstCliente_actual.add(c4);
        //lstCliente_actual.add(c5);
        Assert.assertArrayEquals(lstCliente_esperado.toArray(), lstCliente_actual.toArray());        
    }
    
}
