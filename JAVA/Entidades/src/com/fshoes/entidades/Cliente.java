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
public class Cliente {
    
    private int idcliente;
    private String razonsocial;
    private String ruc;
    private String direccion;
    private boolean estado;

    public Cliente(int idcliente, String razonsocial, String ruc, String direccion, boolean estado) {
        this.idcliente = idcliente;
        this.razonsocial = razonsocial;
        this.ruc = ruc;
        this.direccion = direccion;
        this.estado = estado;
    }

    public Cliente() {
        this(0, "", "", "", false);
    }

    public int getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(int idcliente) {
        this.idcliente = idcliente;
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

    

    
    

}
