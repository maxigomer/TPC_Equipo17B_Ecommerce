<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ecommerce_web.Cuenta.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="card bg-secondary text-white p-4 shadow" style="width: 100%; max-width: 400px;">
            <h3 class="text-center mb-4">Ingreso</h3>
            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="ej: Juan"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Apellido</label>
                <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" placeholder="ej: Suarez"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Telefono (Opcional)</label>
                <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" placeholder="ej: 1123447899"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="ej: tumail@email.com"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Confirmar Contraseña</label>
                <asp:TextBox ID="txtConfirmarPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            

            <asp:Button ID="btnRegister" runat="server" Text="Crear Cuenta" CssClass="btn btn-info w-100 fw-bold mb-2" />
            <asp:Label ID="lblError" runat="server" ForeColor="#FF9999" CssClass="text-center d-block"></asp:Label>
        </div>
    </div>
</asp:Content>
