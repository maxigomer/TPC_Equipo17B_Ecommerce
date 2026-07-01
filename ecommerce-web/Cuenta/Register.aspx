<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ecommerce_web.Cuenta.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .validacion {
            color: red;
            font-size: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="card bg-secondary text-white p-4 shadow" style="width: 100%; max-width: 400px;">
            <h3 class="text-center mb-4">Crear cuenta</h3>
            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="txtNombre" runat="server" />
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="ej: Juan" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNombre" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñÜü\s'-]+$" ErrorMessage="Ingrese un nombre valido." ForeColor="Red" />
            </div>
            <div class="mb-3">
                <label class="form-label">Apellido</label>
                <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="txtApellido" runat="server" />
                <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" placeholder="ej: Suarez" MaxLength="50"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtApellido" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñÜü\s'-]+$" ErrorMessage="Ingrese un apellido valido." ForeColor="Red" />
            </div>
            <div class="mb-3">
                <label class="form-label">Telefono (Opcional)</label>
                <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" placeholder="ej: 1123447899"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono" ValidationExpression="^\+?[0-9\s-]{7,20}$" ErrorMessage="Ingrese un numero de telefono valido." ForeColor="Red" />
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="txtEmail" runat="server" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="ej: tumail@email.com"></asp:TextBox>
                <asp:RegularExpressionValidator ErrorMessage="Ingrese un Mail valido" ForeColor="Red" ControlToValidate="txtEmail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" runat="server" />
            </div>

            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="txtPassword" runat="server" />
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPassword" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$" ErrorMessage="La clave debe contener al menos 8 caracteres, una mayuscula, una minuscula y un numero." ForeColor="Red" />
            </div>
            <div class="mb-3">
                <label class="form-label">Confirmar Contraseña</label>
                <asp:RequiredFieldValidator ErrorMessage="*" CssClass="validacion" ControlToValidate="txtConfirmarPassword" runat="server" />
                <asp:CompareValidator runat="server" ControlToValidate="txtConfirmarPassword" ControlToCompare="txtPassword" ForeColor="Red" ErrorMessage="Las claves no coinciden." />
                <asp:TextBox ID="txtConfirmarPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>


            <asp:Button ID="btnRegister" runat="server" Text="Crear Cuenta" CssClass="btn btn-info w-100 fw-bold mb-2" OnClick="btnRegister_Click" />
            <asp:Label ID="lblError" runat="server" ForeColor="#FF9999" CssClass="text-center d-block"></asp:Label>
        </div>
    </div>
</asp:Content>
