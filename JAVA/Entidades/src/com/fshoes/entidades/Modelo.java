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
public class Modelo implements JSONStreamAware{
    private String codigomodelo;
    private String urlimagen;
    private String horma;
    private String taco;
    private String plataforma;
    private String coleccion;
    private String especificacion;
    private Cliente objcliente;
    private boolean estado;
    
    public Modelo(String codigomodelo, String urlimagen, String horma, String taco, String plataforma, String coleccion, String especificacion, Cliente objcliente, boolean estado) {
        this.codigomodelo = codigomodelo;
        this.urlimagen = urlimagen;
        this.horma = horma;
        this.taco = taco;
        this.plataforma = plataforma;
        this.coleccion = coleccion;
        this.especificacion = especificacion;
        this.objcliente = objcliente;
        this.estado = estado;
    }

    public Modelo() {
        this("", "", "", "", "", "", "", new Cliente(), false);
    }

    public String getCodigomodelo() {
        return codigomodelo;
    }

    public void setCodigomodelo(String codigomodelo) {
        this.codigomodelo = codigomodelo;
    }

    public String getUrlimagen() {
        return urlimagen;
    }

    public void setUrlimagen(String urlimagen) {
        this.urlimagen = urlimagen;
    }

    public String getHorma() {
        return horma;
    }

    public void setHorma(String horma) {
        this.horma = horma;
    }

    public String getTaco() {
        return taco;
    }

    public void setTaco(String taco) {
        this.taco = taco;
    }

    public String getPlataforma() {
        return plataforma;
    }

    public void setPlataforma(String plataforma) {
        this.plataforma = plataforma;
    }

    public String getColeccion() {
        return coleccion;
    }

    public void setColeccion(String coleccion) {
        this.coleccion = coleccion;
    }

    public String getEspecificacion() {
        return especificacion;
    }

    public void setEspecificacion(String especificacion) {
        this.especificacion = especificacion;
    }

    public Cliente getObjcliente() {
        return objcliente;
    }

    public void setObjcliente(Cliente objcliente) {
        this.objcliente = objcliente;
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
        obj.put("codigomodelo", String.valueOf(codigomodelo));
        obj.put("urlimagen", urlimagen);
        obj.put("horma", horma);
        obj.put("taco", taco);
        obj.put("plataforma", plataforma);
        obj.put("coleccion", coleccion);
        obj.put("especificacion", especificacion);
        obj.put("objCliente", objcliente);
        obj.put("estado", estado);
        JSONValue.writeJSONString(obj, out);
    }
    
}
