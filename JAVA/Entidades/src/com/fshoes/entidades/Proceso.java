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
public class Proceso {
    private String codigoproceso;
    private String descripcion;
    private int idmateriales;

    
    public Proceso(String codigoproceso, String descripccion, int idmateriales) {
        this.codigoproceso = codigoproceso;
        this.descripcion = descripccion;
        this.idmateriales = idmateriales;
    }
    
    public Proceso() {
        this("", "", 0);
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

    public int getIdmateriales() {
        return idmateriales;
    }

    public void setIdmateriales(int idmateriales) {
        this.idmateriales = idmateriales;
    }

    
    
    
    
}
