<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="ecommerce_web.Clientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid mt-4">
<%--        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-white">Gestión de Clientes</h2>
            <asp:Button ID="btnNuevoCliente" runat="server" Text="+ Nuevo Cliente" CssClass="btn btn-success" />
        </div>--%>

        <div class="table-responsive">
            <asp:GridView ID="dgvClientes" runat="server" CssClass="table table-dark table-striped table-hover table-bordered" AutoGenerateColumns="true">
            </asp:GridView>
        </div>
    </div>
</asp:Content>
