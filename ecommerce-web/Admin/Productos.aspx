<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="ecommerce_web.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex justify-content-end gap-2 p-1">
            <asp:Button runat="server" ID="btnTest" Text="Test" OnClick="btnTest_Click" CssClass="btn btn-danger mb-1" />
            <asp:Button runat="server" ID="btnCargaProducto" Text="Nuevo Producto" OnClick="btnCargaProducto_Click" CssClass="btn btn-dark mb-1" />
    </div>
    <asp:GridView runat="server" ID="dgvProductos" CssClass="table table-white caption-top" AutoGenerateColumns="false"
        DataKeyNames="Id" AllowPaging="true" PageSize="10">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="chkSeleccionado" OnCheckedChanged="chkSeleccionado_CheckedChanged" AutoPostBack="true" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Producto">
                <ItemTemplate>
                    <a href='CargaProducto.aspx?id=<%#Eval ("Id") %>' class="text-decoration-none text-reset">
                        <div class="d-flex flex-row align-items-center">
                            <asp:Image runat="server" ID="imgProducto" ImageUrl='<%# Eval("ImagenPrincipal") %>' Width="60px" Height="60px" CssClass="me-2" />
                            <h4><%# Eval("Nombre") %></h4>
                        </div>

                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <span class='<%# (bool)Eval("Estado") ? "badge rounded-pill bg-success" : "badge rounded-pill bg-info" %>'>
                        <%# (bool)Eval("Estado") ? "Activo" : "Draft" %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="SKU" DataField="Sku" />
            <asp:BoundField HeaderText="Categoria" DataField="Categoria.Nombre" />
            <asp:BoundField HeaderText="Marca" DataField="Marca.Nombre" />

        </Columns>
    </asp:GridView>

</asp:Content>
