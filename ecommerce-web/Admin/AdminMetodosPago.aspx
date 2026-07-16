<%@ Page Title="Métodos de Pago" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="AdminMetodosPago.aspx.cs" Inherits="ecommerce_web.Admin.AdminMetodosPago" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <h2>Administrar Métodos de Pago</h2>
        <hr />

        <div class="row">
            <div class="col-md-7">
                <asp:GridView ID="dgvMetodos" runat="server" CssClass="table table-striped table-dark" AutoGenerateColumns="false" DataKeyNames="Id" OnRowCommand="dgvMetodos_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Estado" HeaderText="Activo" />
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-warning btn-sm" />
                                <asp:Button ID="btnEstado" runat="server" Text='<%# Convert.ToBoolean(Eval("Estado")) ? "Desactivar" : "Activar" %>' CommandName="CambiarEstado" CommandArgument='<%# Eval("Id") + "|" + Eval("Estado") %>' CssClass='<%# Convert.ToBoolean(Eval("Estado")) ? "btn btn-danger btn-sm" : "btn btn-success btn-sm" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="col-md-5">
                <div class="card bg-dark text-white">
                    <div class="card-body">
                        <h5 class="card-title">
                            <asp:Label ID="lblFormulario" runat="server" Text="Nuevo Método de Pago"></asp:Label>
                        </h5>
                        
                        <div class="mb-3">
                            <label class="form-label">Nombre:</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                            
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" 
                                ControlToValidate="txtNombre" 
                                ErrorMessage="El nombre es obligatorio." 
                                ForeColor="Red" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>

                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary ms-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" />
                        <asp:HiddenField ID="hfIdEditando" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
