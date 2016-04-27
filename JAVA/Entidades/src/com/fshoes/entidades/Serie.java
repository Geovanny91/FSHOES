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
public class Serie {
    private int idserie;
    private int tallas;
    private int pares;
    private Orden codigoorden;

    public Serie(int idserie, int tallas, int pares, Orden codigoorden) {
        this.idserie = idserie;
        this.tallas = tallas;
        this.pares = pares;
        this.codigoorden = codigoorden;
    }

    public Serie() {
        this(0, 0, 0, new Orden());
    }

    public int getIdserie() {
        return idserie;
    }

    public void setIdserie(int idserie) {
        this.idserie = idserie;
    }

    public int getTallas() {
        return tallas;
    }

    public void setTallas(int tallas) {
        this.tallas = tallas;
    }

    public int getPares() {
        return pares;
    }

    public void setPares(int pares) {
        this.pares = pares;
    }

    public Orden getCodigoorden() {
        return codigoorden;
    }

    public void setCodigoorden(Orden codigoorden) {
        this.codigoorden = codigoorden;
    }
}
