<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="ecommerce_web.Cuenta.Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-dark text-white">
            <h3 class="mb-0">Mi Perfil</h3>
        </div>

        <div class="card-body">

            <div class="row">

                <div class="col-md-6 mb-3">
                    <label>Nombre</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Apellido</label>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label>DNI</label>
                    <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"/>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Teléfono</label>
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"/>
                </div>

            </div>

            <asp:Button
                ID="btnGuardar"
                runat="server"
                Text="Guardar Cambios"
                CssClass="btn btn-success"
                OnClick="btnGuardar_Click"/>

            <asp:Label
                ID="lblMensaje"
                runat="server"
                CssClass="ms-3 fw-bold text-success"/>

        </div>

    </div>

</div>

</asp:Content>
