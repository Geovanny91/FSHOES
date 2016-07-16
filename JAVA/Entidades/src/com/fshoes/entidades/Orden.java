/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.entidades;

import java.util.Date;

/**
 *
 * @author flores
 */
public class Orden {
    private String codigoorden;
    private String orden_pedido;
    private Date fecha_emision;
    private Date fecha_entrega;
    private int total;
    private FichaTecnica objFicha;

    public Orden(String codigoorden, String orden_pedido, Date fecha_emision, Date fecha_entrega, int total, FichaTecnica objFicha) {
        this.codigoorden = codigoorden;
        this.orden_pedido = orden_pedido;
        this.fecha_emision = fecha_emision;
        this.fecha_entrega = fecha_entrega;
        this.total = total;
        this.objFicha = objFicha;
    }

    public Orden() {
        this("","", new Date(), new Date(), 0, new FichaTecnica());
    }

    
    
    public String getCodigoorden() {
        return codigoorden;
    }

    public void setCodigoorden(String codigoorden) {
        this.codigoorden = codigoorden;
    }

    public String getOrden_pedido() {
        return orden_pedido;
    }

    public void setOrden_pedido(String orden_pedido) {
        this.orden_pedido = orden_pedido;
    }

    public Date getFecha_emision() {
        return fecha_emision;
    }

    public void setFecha_emision(Date fecha_emision) {
        this.fecha_emision = fecha_emision;
    }

    public Date getFecha_entrega() {
        return fecha_entrega;
    }

    public void setFecha_entrega(Date fecha_entrega) {
        this.fecha_entrega = fecha_entrega;
    }

       

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public FichaTecnica getObjFicha() {
        return objFicha;
    }

    public void setObjFicha(FichaTecnica objFicha) {
        this.objFicha = objFicha;
    }
}
