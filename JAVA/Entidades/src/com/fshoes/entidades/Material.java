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
 * @author Geovanny
 */
public class Material implements JSONStreamAware{
    private int idmaterial;
    private String nombre;
    private String descripcion;
    private String unidadmedida;
    private int cantidaddocena;
    private float preciounitario;
    private String tipo;
    private String color;
    private Proveedor objProveedor;

    public Material(int idmaterial, String nombre, String descripccion, String unidadmedida, int cantidaddocena, float preciounitario, String tipo, String color, Proveedor idproveedor) {
        this.idmaterial = idmaterial;
        this.nombre = nombre;
        this.descripcion = descripccion;
        this.unidadmedida = unidadmedida;
        this.cantidaddocena = cantidaddocena;
        this.preciounitario = preciounitario;
        this.tipo = tipo;
        this.color = color;
        this.objProveedor = idproveedor;
    }

    public Material() {
        this(0, "", "", "", 0, 0, "", "", new Proveedor());
    }

    public int getIdmaterial() {
        return idmaterial;
    }

    public void setIdmaterial(int idmaterial) {
        this.idmaterial = idmaterial;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUnidadmedida() {
        return unidadmedida;
    }

    public void setUnidadmedida(String unidadmedida) {
        this.unidadmedida = unidadmedida;
    }

    public int getCantidaddocena() {
        return cantidaddocena;
    }

    public void setCantidaddocena(int cantidaddocena) {
        this.cantidaddocena = cantidaddocena;
    }

    public float getPreciounitario() {
        return preciounitario;
    }

    public void setPreciounitario(float preciounitario) {
        this.preciounitario = preciounitario;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Proveedor getObjProveedor() {
        return objProveedor;
    }

    public void setObjProveedor(Proveedor objProveedor) {
        this.objProveedor = objProveedor;
    }    

    @Override
    public void writeJSONString(Writer out) throws IOException {
        LinkedHashMap obj = new LinkedHashMap();        
        obj.put("idmaterial",idmaterial);
        obj.put("nombre",nombre);
        obj.put("descripcion",descripcion);
        obj.put("unidadmedida",unidadmedida);
        obj.put("cantidaddocena",cantidaddocena);
        obj.put("preciounitario",preciounitario);
        obj.put("tipo",tipo);
        obj.put("color",color);
        obj.put("objProveedor",objProveedor);
        JSONValue.writeJSONString(obj, out);
    }
    
    
    

}
