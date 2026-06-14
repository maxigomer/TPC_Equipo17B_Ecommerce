<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="ecommerce_web.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="text-end">
        <%--        <asp:DropDownList runat="server" ID="ddActivo" CssClass="btn btn-primary mb-1 dropdown-toggle"></asp:DropDownList>--%>
        <asp:Button runat="server" ID="btnCargaProducto" Text="Nuevo Producto" OnClick="btnCargaProducto_Click" CssClass="btn btn-dark mb-1" />
    </div>
    <asp:GridView runat="server" ID="dgvProductos" CssClass="table table-dark table-bordered" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="chkSeleccionado" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Producto">
                <ItemTemplate>
                    <div class="d-flex flex-row align-items-center">
                        <asp:Image runat="server" ID="imgProducto" ImageUrl="https://static.thenounproject.com/png/4595376-200.png" Width="100px" Height="100px" />
                        <h3><%# Eval("Nombre") %></h3>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="SKU" DataField="Sku" />
            <%--            <asp:BoundField HeaderText="Producto" DataField="Nombre" />--%>
            <asp:BoundField HeaderText="Categoria" DataField="Categoria.Nombre" />
            <asp:BoundField HeaderText="Marca" DataField="Marca.Nombre" />

        </Columns>
    </asp:GridView>

</asp:Content>
