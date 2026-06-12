<%@ Page EnableEventValidation="false" Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="CargaProducto.aspx.cs" Inherits="ecommerce_web.CargaProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex">
        <div class="flex-grow-1">
            <label for="txtNombre" class="form-label">Nombre</label>
            <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
            <label for="txtDescripcion" class="form-label">Descripcion</label>
            <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control" TextMode="MultiLine" Rows="10" />

        </div>

        <div style="width: 200px">
                <label for="ddCategoria" class="form-label">Categoria</label>
                <asp:DropDownList runat="server" ID="ddCategoria" CssClass="form-select select2"></asp:DropDownList>


                <label for="ddCategoria" class="form-label">Marca</label>
                <asp:DropDownList runat="server" ID="ddMarca" CssClass="form-select select2"></asp:DropDownList>

        </div>

    </div>
    <asp:Button runat="server" ID="btnAgregarProducto" OnClick="btnAgregarProducto_Click" />
</asp:Content>
