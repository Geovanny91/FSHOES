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
public class DetalleOrden implements JSONStreamAware{
    
    private Orden objOrden;
    private Trabajador objTrabajador;
    private boolean estado;

    public DetalleOrden(Orden objOrden, Trabajador objTrabajador, boolean estado) {
        this.objOrden = objOrden;
        this.objTrabajador = objTrabajador;
        this.estado = estado;
    }

    public DetalleOrden() {
        this(new Orden(), new Trabajador(), false);
    }

    public Orden getObjOrden() {
        return objOrden;
    }

    public void setObjOrden(Orden objOrden) {
        this.objOrden = objOrden;
    }

    public Trabajador getObjTrabajador() {
        return objTrabajador;
    }

    public void setObjTrabajador(Trabajador objTrabajador) {
        this.objTrabajador = objTrabajador;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }
   
    @Override
    public void writeJSONString(Writer out) throws IOException {
        LinkedHashMap obj  = new LinkedHashMap();
        obj.put("objOrden", objOrden);
        obj.put("objTrabajador", objTrabajador);
        obj.put("estado", estado);
        JSONValue.writeJSONString(obj, out);                
    }   
    
}
