/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.entidades;

import java.io.IOException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import org.json.simple.JSONStreamAware;
import org.json.simple.JSONValue;

/**
 *
 * @author flores
 */
public class Orden implements JSONStreamAware{
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

    @Override
    public void writeJSONString(Writer out) throws IOException {
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");        
        final String stringDate = dateFormat.format(fecha_emision);
        final java.sql.Date fecha_emision_f = java.sql.Date.valueOf(stringDate);
        
        final String stringDate_dos = dateFormat.format(fecha_entrega);
        final java.sql.Date fecha_entrega_f = java.sql.Date.valueOf(stringDate_dos);
        
        LinkedHashMap obj = new LinkedHashMap();        
        obj.put("codigoorden", codigoorden);
        obj.put("orden_pedido", orden_pedido);        
        obj.put("fecha_emision", String.valueOf(fecha_emision_f));
        obj.put("fecha_entrega", String.valueOf(fecha_entrega_f));
        obj.put("total", total);
        obj.put("objFicha", objFicha);       
        JSONValue.writeJSONString(obj, out);
    }
}
