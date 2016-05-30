/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.entidades;

import java.util.Date;

/**
 *
 * @author Geovanny Rìos Abarca
 */
public class Trabajador {
    
    private int idempleado;
    private String dni;
    private String nombres;
    private String ape_paterno;
    private String ape_materno;
    private String direccion;
    private String telefono;
    private String celular;
    private String fecha_nacimiento;
    private String usuario;
    private String contrasena;
    private boolean estado;
    private Proceso codigoproceso;

    public Trabajador(int idempleado, String dni, String nombres, String ape_paterno, String ape_materno, String direccion, String telefono, String celular, String fecha_nacimiento, String usuario, String contrasena, boolean estado, Proceso codigoproceso) {
        this.idempleado = idempleado;
        this.dni = dni;
        this.nombres = nombres;
        this.ape_paterno = ape_paterno;
        this.ape_materno = ape_materno;
        this.direccion = direccion;
        this.telefono = telefono;
        this.celular = celular;
        this.fecha_nacimiento = fecha_nacimiento;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.estado = estado;
        this.codigoproceso = codigoproceso;
    }

    public Trabajador() {
        this(0, "", "", "", "", "", "", "", "", "", "", false, new Proceso());
    }

    public int getIdempleado() {
        return idempleado;
    }

    public void setIdempleado(int idempleado) {
        this.idempleado = idempleado;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApe_paterno() {
        return ape_paterno;
    }

    public void setApe_paterno(String ape_paterno) {
        this.ape_paterno = ape_paterno;
    }

    public String getApe_materno() {
        return ape_materno;
    }

    public void setApe_materno(String ape_materno) {
        this.ape_materno = ape_materno;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }    

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }    

    public Proceso getCodigoproceso() {
        return codigoproceso;
    }

    public void setCodigoproceso(Proceso codigoproceso) {
        this.codigoproceso = codigoproceso;
    }

    public String getNombreCompleto(){
        return (this.nombres + " " + this.ape_paterno + " " + this.ape_materno);
    }
    
}
