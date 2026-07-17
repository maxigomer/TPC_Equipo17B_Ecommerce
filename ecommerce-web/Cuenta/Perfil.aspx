<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="ecommerce_web.Cuenta.Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>

    <div class="container mt-5">

        <div class="card shadow mb-3">

            <div class="card-header bg-dark text-white">
                <h3 class="mb-0">Mi Perfil</h3>
            </div>

            <div class="card-body">

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label>Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label>Apellido</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label>DNI</label>
                        <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" />
                        <asp:Label ID="lblDni" runat="server" CssClass="text-warning small" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDNI" ValidationExpression="^\d{7,8}$" ErrorMessage="Ingrese un DNI Valido." CssClass="text-danger" Display="Dynamic" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label>Teléfono</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono" ValidationExpression="^\+?[0-9\s-]{7,20}$" ErrorMessage="Ingrese un numero de telefono valido." ForeColor="Red" />
                    </div>

                </div>

                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-success" OnClick="btnGuardar_Click" />

                <asp:Button ID="btnCerrarSesion" runat="server" Text="Cerrar sesión" CssClass="btn btn-outline-danger ms-2" OnClick="btnCerrarSesion_Click" />

                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-3 fw-bold text-success" />

            </div>

        </div>

        <div class="card shadow mb-3">
            <div class="card-header bg-dark text-white">
                <h3 class="mb-0">Direcciones</h3>
            </div>

            <div class="card-body">
                <asp:DropDownList runat="server" ID="ddlDirecciones" CssClass="form-select mb-3" OnSelectedIndexChanged="ddlDirecciones_SelectedIndexChanged" AutoPostBack="true" ></asp:DropDownList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCalle" ErrorMessage="Campo Obligatorio" CssClass="text-danger" />
                <asp:TextBox runat="server" CssClass="form-control mb-3" ID="txtCalle" placeholder="Calle" />
                <div class="d-flex gap-3 mb-3">
                    <div class="flex-grow-1">
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNumeroCalle" ValidationExpression="^\d{3,4}$" ErrorMessage="Ingrese datos validos" CssClass="text-danger" Display="Dynamic" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumeroCalle" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" CssClass="form-control mb-3" ID="txtNumeroCalle" placeholder="Numero o Altura" />

                    </div>
                </div>

                <div class="d-flex gap-3 mb-3">
                    <div class="flex-grow-1">
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCodigoPostal" ValidationExpression="^([A-Za-z]\d{4}[A-Za-z]{3}|\d{4})$" ErrorMessage="Ingrese un Codigo Postal Valido" CssClass="text-danger" Display="Dynamic" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodigoPostal" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtCodigoPostal" placeholder="Codigo Postal" />
                    </div>

                    <div class="flex-grow-1">
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtLocalidad" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñ ]{2,50}$" ErrorMessage="Ingrese datos validos" CssClass="text-danger" Display="Dynamic" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLocalidad" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtLocalidad" placeholder="Localidad" />
                    </div>

                </div>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtObservaciones" ValidationExpression="^.{0,150}$" ErrorMessage="Las observaciones no pueden superar 150 caracteres" CssClass="text-danger" Display="Dynamic" />
                <asp:TextBox runat="server" CssClass="form-control mb-3" ID="txtObservaciones" placeholder="Observaciones (Opcional)" TextMode="MultiLine" Rows="5" />
                <asp:Button ID="btnGuardarDireccion" runat="server" Text="Guardar Direccion" CssClass="btn btn-success" OnClick="btnGuardarDireccion_Click" />
                <asp:Button ID="btnEliminarDireccion" runat="server" Text="Eliminar Direccion" CssClass="btn btn-outline-danger ms-2" OnClick="btnEliminarDireccion_Click" Visible="false"  />

            </div>

        </div>

    </div>

</asp:Content>
