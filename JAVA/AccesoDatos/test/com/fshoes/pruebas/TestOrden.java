/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.pruebas;

import com.fshoes.accesodatos.OrdenAD;
import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Orden;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author masong
 */
public class TestOrden {
    
    public TestOrden() {
    }
    
    @Before
    public void setUp() {
    }
    
    @Test
    public void registrarOrden(){
        try {
            System.out.println("REGISTRAR ORDEN");
            boolean rpt = false;
            FichaTecnica ficha = new FichaTecnica();
            ficha.setCodigoficha("F02");
            
            //SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            //String fechaStr = "2016-07-16 10:49:29.10000";  
            //Date fechaNueva = format.parse(fechaStr);
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date utilDate = dateFormat.parse("2016-07-16");            
            final String stringDate= dateFormat.format(utilDate);
            final java.sql.Date sqlDate=  java.sql.Date.valueOf(stringDate);

            String f_entrega = "2016-07-19";
            Date utilDate_dos = dateFormat.parse(f_entrega);
            final String stringDate_dos = dateFormat.format(utilDate_dos);
            final java.sql.Date fecha_entrega=  java.sql.Date.valueOf(stringDate_dos);  
            
            Orden orden = new Orden("045-ER", "1547", sqlDate, fecha_entrega, 30, ficha);
            rpt = OrdenAD.Instancia().registrarOrden(orden, "registrarOrden");
            
            int actual = rpt ? 1:0;
            int esperado = 1;
            
            assertEquals(esperado, actual);
        } catch (Exception ex) {
            Logger.getLogger(TestOrden.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @After
    public void tearDown() {
    }
    
}
