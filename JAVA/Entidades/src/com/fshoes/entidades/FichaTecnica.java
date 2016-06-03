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
public class FichaTecnica implements JSONStreamAware{
    private String codigoficha;
    private String plataforma;
    private String taco;
    private String color;
    private String coleccion;
    private String urlimagen;
    private String codigomodelo;

    public FichaTecnica(String codigoficha, String plataforma, String taco, String color, String coleccion, String urlimagen, String codigomodelo) {
        this.codigoficha = codigoficha;
        this.plataforma = plataforma;
        this.taco = taco;
        this.color = color;
        this.coleccion = coleccion;
        this.urlimagen = urlimagen;
        this.codigomodelo = codigomodelo;
    }

    public FichaTecnica() {
        this("", "", "", "", "", "", "");
    }

    public String getCodigoficha() {
        return codigoficha;
    }

    public void setCodigoficha(String codigoficha) {
        this.codigoficha = codigoficha;
    }

    public String getPlataforma() {
        return plataforma;
    }

    public void setPlataforma(String plataforma) {
        this.plataforma = plataforma;
    }

    public String getTaco() {
        return taco;
    }

    public void setTaco(String taco) {
        this.taco = taco;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getColeccion() {
        return coleccion;
    }

    public void setColeccion(String coleccion) {
        this.coleccion = coleccion;
    }

    public String getUrlimagen() {
        return urlimagen;
    }

    public void setUrlimagen(String urlimagen) {
        this.urlimagen = urlimagen;
    }

    public String getCodigomodelo() {
        return codigomodelo;
    }

    public void setCodigomodelo(String codigomodelo) {
        this.codigomodelo = codigomodelo;
    }

    @Override
    public void writeJSONString(Writer out) throws IOException {
        LinkedHashMap obj = new LinkedHashMap();        
        obj.put("codigoficha", codigoficha);
        obj.put("plataforma", plataforma);
        obj.put("taco", taco);
        obj.put("color", color);
        obj.put("coleccion", coleccion);
        obj.put("urlimagen", urlimagen);
        obj.put("codigomodelo", codigomodelo);
        JSONValue.writeJSONString(obj, out);
    }    
}
