/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.entidades;

import java.io.IOException;
import java.io.Writer;
import java.util.LinkedHashMap;
import org.json.simple.JSONStreamAware;
import org.json.simple.JSONValue;

/**
 *
 * @author flores
 */
public class Proceso implements JSONStreamAware{
    private String codigoproceso;
    private String descripcion;    

    
    public Proceso(String codigoproceso, String descripccion) {
        this.codigoproceso = codigoproceso;
        this.descripcion = descripccion;        
    }
    
    public Proceso() {
        this("", "");
    }

    public String getCodigoproceso() {
        return codigoproceso;
    }

    public void setCodigoproceso(String codigoproceso) {
        this.codigoproceso = codigoproceso;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override
    public void writeJSONString(Writer out) throws IOException {
        LinkedHashMap obj = new LinkedHashMap();
        obj.put("codigoproceso", codigoproceso);
        obj.put("descripcion", descripcion);        
        JSONValue.writeJSONString(obj, out);
    }
        
}
