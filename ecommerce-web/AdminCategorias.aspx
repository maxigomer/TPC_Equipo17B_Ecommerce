<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="AdminCategorias.aspx.cs" Inherits="ecommerce_web.AdminCategorias" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
    <h2>Administrar Categorías</h2>
    <hr />

    <div class="row">
        <div class="col-md-6">
            <asp:GridView ID="dgvCategorias" runat="server" CssClass="table table-striped table-dark" AutoGenerateColumns="true">
            </asp:GridView>
        </div>

        <div class="col-md-6">
            <div class="card bg-dark text-white">
                <div class="card-body">
                    <h5 class="card-title">Nueva Categoría</h5>
                    
                    <div class="mb-3">
                        <label class="form-label">Nombre de la Categoría:</label>
                        <asp:TextBox ID="txtNombreCategoria" runat="server" CssClass="form-control"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" 
                            ControlToValidate="txtNombreCategoria" 
                            ErrorMessage="El nombre es obligatorio." 
                            ForeColor="Red" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-primary" OnClick="btnAgregar_Click" />
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
