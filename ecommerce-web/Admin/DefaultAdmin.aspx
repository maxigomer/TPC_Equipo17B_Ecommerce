<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="DefaultAdmin.aspx.cs" Inherits="ecommerce_web.DefaultAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="d-flex justify-content-end gap-2 p-1">
        <asp:Button runat="server" ID="btnActualizarColecciones" Text="Actualizar" OnClick="btnActualizarColecciones_Click" CssClass="btn btn-dark mb-1" />
    </div>
    <asp:GridView runat="server" ID="dgvColeccionesMenu" CssClass="table table-white caption-top" AutoGenerateColumns="false" DataKeyNames="Id">
        <Columns>
            <asp:TemplateField HeaderText="Nombre de la Coleccion">

            </asp:TemplateField>


        </Columns>
    </asp:GridView>

</asp:Content>
