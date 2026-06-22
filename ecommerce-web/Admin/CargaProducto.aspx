<%@ Page EnableEventValidation="false" Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="CargaProducto.aspx.cs" Inherits="ecommerce_web.CargaProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .validacion{
            color: red;
            font-size: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <div class="d-flex gap-3">
        <div class="flex-grow-1">
            <label for="txtNombre" class="form-label">Nombre</label>
            <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="*" ControlToValidate="txtNombre" runat="server" />
            <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />

            <label for="txtDescripcion" class="form-label">Descripcion</label>
            <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control" TextMode="MultiLine" Rows="10" />

            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="d-flex">
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtUrlImagen" ValidationExpression="^https://.+" ErrorMessage="Ingrese una URL valida" Display="Dynamic" CssClass="validacion" ValidationGroup="Imagen" />
                        <asp:TextBox runat="server" ID="txtUrlImagen" CssClass="form-control flex-grow-1 m-2" placeholder="Url Imagen" />
                        <asp:Button runat="server" ID="btnAgregarUrlImagen" OnClick="btnAgregarUrlImagen_Click" CssClass="form-control m-1" Text="Agregar" Style="width: 100px" ValidationGroup="Imagen" />

                    </div>
                    <div class="d-flex flex-wrap gap-3">
                        <asp:Repeater runat="server" ID="repImagenes">
                            <ItemTemplate>
                                <div class="position-relative border rounded overflow-hiden shadow-sm" style="min-width: 120px; max-width: 180px; aspect-ratio: 1;">
                                    <asp:Button ID="btnEliminarImagen" runat="server" CommandArgument='<%#Eval("Url") %>' OnClick="btnEliminarImagen_Click"
                                        CssClass="btn btn-danger btn-sm position-absolute top-0 end-0 m-1" Text="X" CausesValidation="false"></asp:Button>
                                    <img src='<%#Eval("Url") %>' class="w-100 h-100" style="object-fit: cover" />

                                </div>

                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>


        </div>

        <div style="width: 200px">
            <label for="ddEstado" class="form-label">Estado</label>
            <asp:DropDownList runat="server" ID="ddEstado" CssClass="form-select"></asp:DropDownList>

            <label for="ddCategoria" class="form-label">Categoria</label>
            <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="ddCategoria" runat="server" />
            <asp:DropDownList runat="server" ID="ddCategoria" CssClass="form-select select2"></asp:DropDownList>


            <label for="ddCategoria" class="form-label">Marca</label>
            <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="ddMarca" runat="server" />
            <asp:DropDownList runat="server" ID="ddMarca" CssClass="form-select select2"></asp:DropDownList>

            <label for="txtSku" class="form-label">SKU</label>
            <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="txtSku" runat="server" />
            <asp:Label Text="" ID="lblSku" runat="server" Style="color: red;" />
            <%--<asp:CustomValidator ErrorMessage="errormessage" ControlToValidate="txtSku" ID="cvSku" runat="server" OnServerValidate="cvSku_ServerValidate" />--%>
            <asp:TextBox runat="server" ID="txtSku" CssClass="form-control" />

            <label for="txtStock" class="form-label">Stock</label>
            <asp:TextBox runat="server" ID="txtStock" CssClass="form-control" TextMode="Number" min="0" Text="0"></asp:TextBox>

            <label for="txtPrecio" class="form-label">Precio</label>
            <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="txtPrecio" runat="server" />
            <div class="input-group">
                <span class="input-group-text">$</span>
                <asp:TextBox runat="server" ID="txtPrecio" TextMode="Number" min="0" step="0.01" CssClass="form-control"></asp:TextBox>
            </div>

            <label for="txtCosto" class="form-label">Costo</label>
            <div class="input-group">
                <span class="input-group-text">$</span>
                <asp:TextBox runat="server" ID="txtCosto" TextMode="Number" min="0" step="0.01" CssClass="form-control"></asp:TextBox>
            </div>

        </div>

    </div>
    <asp:Button runat="server" ID="btnAgregarProducto" OnClick="btnAgregarProducto_Click" CssClass="form-control m-1 btn btn-primary" Text="Agregar Producto" Style="width: 200px;" />
    <asp:ValidationSummary runat="server" CssClass="alert alert-danger" HeaderText="los valores con * son requeridos" ShowMessageBox="false" ShowSummary="true" DisplayMode="SingleParagraph"  />
</asp:Content>
