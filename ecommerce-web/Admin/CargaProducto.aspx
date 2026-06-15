<%@ Page EnableEventValidation="false" Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="CargaProducto.aspx.cs" Inherits="ecommerce_web.CargaProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <div class="d-flex">
        <div class="flex-grow-1">
            <label for="txtNombre" class="form-label">Nombre</label>
            <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />

            <label for="txtDescripcion" class="form-label">Descripcion</label>
            <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control" TextMode="MultiLine" Rows="10" />

            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="d-flex">
                        <asp:TextBox runat="server" ID="txtUrlImagen" CssClass="form-control flex-grow-1 m-2" placeholder="Url Imagen" />
                        <asp:Button runat="server" ID="btnAgregarUrlImagen" OnClick="btnAgregarUrlImagen_Click" CssClass="form-control m-1" Text="Agregar" Style="width: 100px" />

                    </div>
                    <asp:BulletedList runat="server" ID="blImagenes"></asp:BulletedList>

                </ContentTemplate>
            </asp:UpdatePanel>


        </div>

        <div style="width: 200px">
            <label for="ddEstado" class="form-label">Estado</label>
            <asp:DropDownList runat="server" ID="ddEstado" CssClass="form-select"></asp:DropDownList>

            <label for="ddCategoria" class="form-label">Categoria</label>
            <asp:DropDownList runat="server" ID="ddCategoria" CssClass="form-select select2"></asp:DropDownList>


            <label for="ddCategoria" class="form-label">Marca</label>
            <asp:DropDownList runat="server" ID="ddMarca" CssClass="form-select select2"></asp:DropDownList>

            <label for="txtSku" class="form-label">SKU</label>
            <asp:TextBox runat="server" ID="txtSku" CssClass="form-control" />

            <label for="txtStock" class="form-label">Stock</label>
            <asp:TextBox runat="server" ID="txtStock" CssClass="form-control" TextMode="Number" min="0" Text="0"></asp:TextBox>

            <label for="txtPrecio" class="form-label">Precio</label>
            <div class="input-group">
                <span class="input-group-text">$</span>
                <asp:TextBox runat="server" ID="txtPrecio" TextMode="Number" min="0" CssClass="form-control"></asp:TextBox>
            </div>

            <label for="txtCosto" class="form-label">Costo</label>
            <div class="input-group">
                <span class="input-group-text">$</span>
                <asp:TextBox runat="server" ID="txtCosto" TextMode="Number" min="0" CssClass="form-control"></asp:TextBox>
            </div>

        </div>

    </div>
    <asp:Button runat="server" ID="btnAgregarProducto" OnClick="btnAgregarProducto_Click" Text="Agregar Producto" />
</asp:Content>
