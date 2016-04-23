/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.entidades;

/**
 *
 * @author flores
 */
public class Proveedor {
    private int idproveedor;
    private String razonsocial;
    private String ruc;
    private String direccion;
    private int estado;

    public Proveedor(int idproveedor, String razonsocial, String ruc, String direccion, int estado) {
        this.idproveedor = idproveedor;
        this.razonsocial = razonsocial;
        this.ruc = ruc;
        this.direccion = direccion;
        this.estado = estado;
    }

    public Proveedor() {
        this(0, "", "", "", 0);        
    }

    public int getIdproveedor() {
        return idproveedor;
    }

    public void setIdproveedor(int idproveedor) {
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

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
    
        
}
