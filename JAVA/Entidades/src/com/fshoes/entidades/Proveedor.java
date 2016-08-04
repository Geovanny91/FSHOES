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
public class Proveedor implements JSONStreamAware{
    private Long idproveedor;
    private String razonsocial;
    private String ruc;
    private String direccion;
    private boolean estado;

    public Proveedor(Long idproveedor, String razonsocial, String ruc, String direccion, boolean estado) {
        this.idproveedor = idproveedor;
        this.razonsocial = razonsocial;
        this.ruc = ruc;
        this.direccion = direccion;
        this.estado = estado;
    }

    public Proveedor() {
        this(new Long(0), "", "", "", false);        
    }

    public Long getIdproveedor() {
        return idproveedor;
    }

    public void setIdproveedor(Long idproveedor) {
        this.idproveedor = idproveedor;
    }    

    public String getRazonsocial() {
        return razonsocial;
    }

    public void setRazonsocial(String razonsocial) {
        this.razonsocial = razonsocial;
    }

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    @Override
    public void writeJSONString(Writer out) throws IOException {
        LinkedHashMap obj = new LinkedHashMap();        
        obj.put("idproveedor",idproveedor);
        obj.put("razonsocial",razonsocial);
        obj.put("ruc",ruc);
        obj.put("direccion",direccion);
        obj.put("estado",estado);        
        JSONValue.writeJSONString(obj, out);
    }
        
}
