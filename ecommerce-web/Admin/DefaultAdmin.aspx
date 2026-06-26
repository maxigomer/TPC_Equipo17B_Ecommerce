<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="DefaultAdmin.aspx.cs" Inherits="ecommerce_web.DefaultAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <div class="d-flex justify-content-end gap-2 p-1">
        <asp:Button runat="server" ID="btnActualizarColecciones" Text="Actualizar" OnClick="btnActualizarColecciones_Click" CssClass="btn btn-dark mb-1" />
    </div>
    <asp:GridView runat="server" ID="dgvColeccionesMenu" CssClass="table table-white caption-top" AutoGenerateColumns="false" DataKeyNames="Id" OnRowDataBound="dgvColeccionesMenu_RowDataBound">
        <Columns>

            <asp:TemplateField HeaderText="Nombre de la Coleccion">
                <ItemTemplate>
                    <asp:TextBox runat="server" ID="txtNombre" Text='<%# Eval("Nombre") %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Criterio">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlCriterio" OnSelectedIndexChanged="ddlCriterio_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Filtro">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlFiltro"></asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="ddlEstado"></asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>


        </Columns>
    </asp:GridView>

    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="d-flex justify-content-end gap-2 p-1">
                <asp:Button runat="server" ID="btnActualizarBanner" Text="Actualizar" OnClick="btnActualizarBanner_Click"  CssClass="btn btn-dark mb-1" />
            </div>
            <div class="flex-column">

                <div class="d-flex">
                    <asp:TextBox runat="server" ID="txtUrlBanner" CssClass="form-control flex-grow-1 m-2" placeholder="Url Imagen" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtUrlBanner" ValidationExpression="^https://.+" ErrorMessage="Ingrese una URL valida" Display="Dynamic" CssClass="alert alert-danger" ValidationGroup="Imagen" />
                    <asp:Button runat="server" ID="btnUrlBanner" OnClick="btnUrlBanner_Click" CssClass="form-control m-1" Text="Agregar" Style="width: 100px" ValidationGroup="Imagen" />

                </div>
                <div class="position-relative border border-dashed rounded-2 overflow-hidden mx-auto" style="height: 250px;">
                    <asp:Image runat="server" ID="imgBanner" CssClass="w-100 h-100" Style="object-fit: cover;" ImageUrl="https://marketerosdehoy.com/wp-content/uploads/2019/04/banner-que-es.png" />
                </div>
            </div>
        </ContentTemplate>

    </asp:UpdatePanel>

</asp:Content>
