<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ecommerce_web.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="card bg-secondary text-white p-4 shadow" style="width: 100%; max-width: 400px;">
            <h3 class="text-center mb-4">Ingreso</h3>
            
            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="admin@mail.com"></asp:TextBox>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            
            <asp:Button ID="btnLoginAcceder" runat="server" Text="Ingresar" CssClass="btn btn-info w-100 fw-bold mb-2" OnClick="btnLoginAcceder_Click" />
            <div class="text-center justify-content-center d-flex p-2 mb-3">
                <p>¿No tenes cuenta todavia?</p>
                <a href="#" class="ps-2" style="color: black;">Crear Cuenta</a>
            </div>
            
            <asp:Label ID="lblError" runat="server" ForeColor="#FF9999" CssClass="text-center d-block"></asp:Label>
        </div>
    </div>
</asp:Content>
