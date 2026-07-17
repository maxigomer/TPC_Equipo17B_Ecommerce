<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="Pedidos.aspx.cs" Inherits="ecommerce_web.Pedidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-white">Gestión de Pedidos</h2>
            <asp:Button ID="btnNuevoPedido" runat="server" Text="+ Nuevo Pedido" CssClass="btn btn-success" />
        </div>

        <div class="table-responsive">
            <asp:GridView ID="dgvPedidos" runat="server" CssClass="table table-dark table-striped table-hover table-bordered" AutoGenerateColumns="false" DataKeyNames="Id" OnRowDataBound="dgvPedidos_RowDataBound" >

    <Columns>

        <asp:BoundField HeaderText="Id" DataField="Id" />

        <asp:BoundField HeaderText="Nombre" DataField="Cliente.NombreCompleto" />

        <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" />

        <asp:BoundField HeaderText="Monto Total" DataField="Precio" />

        <asp:BoundField HeaderText="Estado" DataField="Estado" />

<%--        <asp:TemplateField HeaderText="Cambiar Estado">

            <ItemTemplate>

                <asp:DropDownList 
                    ID="ddlEstado" 
                    runat="server"
                    CssClass="form-select">
                </asp:DropDownList>


                <asp:Button 
                    ID="btnEstado"
                    runat="server"
                    Text="Actualizar"
                    CssClass="btn btn-primary btn-sm mt-2"
                    CommandName="CambiarEstado"
                    CommandArgument='<%# Eval("Id") %>' />

            </ItemTemplate>

        </asp:TemplateField>--%>


    </Columns>

</asp:GridView>

        </div>
    </div>
</asp:Content>
