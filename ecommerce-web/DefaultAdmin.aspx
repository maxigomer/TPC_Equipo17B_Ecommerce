<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="DefaultAdmin.aspx.cs" Inherits="ecommerce_web.DefaultAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView runat="server" ID="dgvProductos" CssClass="table table-dark table-bordered" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField HeaderText="SKU" DataField="Sku" />
            <asp:BoundField HeaderText="Producto" DataField="Nombre" />
            <asp:BoundField HeaderText="Precio" DataField="Precio" />
            <asp:BoundField HeaderText="Marca" DataField="Marca.Nombre" />

        </Columns>
    </asp:GridView>
</asp:Content>
