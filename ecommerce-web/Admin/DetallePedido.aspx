<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="DetallePedido.aspx.cs" Inherits="ecommerce_web.Admin.DetallePedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex gap-4 align-items-start">
        <!-- Izquierda -->
        <div class="flex-grow-1">

            <div class="card shadow-sm mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Productos del Pedido</h5>
                </div>
                <div class="card-body">
                    <asp:Repeater ID="rpResumenPedido" runat="server">
                        <ItemTemplate>

                            <div class="d-flex align-items-center mb-4">
                                <div class="position-relative">
                                    <asp:Image runat="server" ID="imgItem" CssClass="rounded border" Style="width: 70px; height: 70px; object-fit: contain;" ImageUrl='<%# Eval("Imagen") %>' />
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-dark">
                                        <%# Eval("Cantidad") %>
                                    </span>
                                </div>

                                <div class="ms-3 flex-grow-1">
                                    <div class="fw-semibold"><%# Eval("Nombre") %></div>
                                    <div class="fw-bold">$<%# Eval("Precio") %></div>


                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>

                </div>

                <div class="d-flex justify-content-end">
                    <h5 class="mb-0">Total:
                        <asp:Label ID="lblTotal" runat="server" /></h5>
                </div>

            </div>

            <div class="card shadow-sm">
                <div class="card-header">
                    <h5 class="mb-0">Observaciones</h5>
                </div>

                <div class="card-body">
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtObservaciones" ValidationExpression="^.{0,150}$" ErrorMessage="Las observaciones no pueden superar 150 caracteres" CssClass="text-danger" Display="Dynamic" />
                    <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" MaxLength="150" />
                    <div class="d-flex justify-content-between mt-2">
                        <span class="text-muted">Maximo 150 caracteres</span>
                        <asp:Button ID="btnGuardarObservacion" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardarObservacion_Click" />
                    </div>

                    <asp:Panel ID="pnlObservaciones" runat="server">
                        <hr />

                        <h6 class="fw-bold mb-3">Historial de Observaciones</h6>

                        <asp:Repeater ID="rpObservaciones" runat="server">
                            <ItemTemplate>
                                <div class="border rounded p-3 mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <strong><%# Eval("Observacion") %></strong>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </asp:Panel>
                    <asp:Panel ID="pnlObservacionesVacias" runat="server">
                        <div class="text-center text-muted py-3">No hay Observaciones para este pedido.</div>
                    </asp:Panel>
                </div>
            </div>

        </div>

        <!-- Derecha -->
        <div class="d-flex flex-column gap-3" style="width: 350px;">
            <div class="card shadow-sm">
                <div class="card-header">
                    <h5 class="mb-0">Cliente</h5>
                </div>
                <div class="card-body">
                    <p class="mb-3">
                        <strong>Nombre</strong><br />
                        <asp:Label ID="lblNombre" runat="server" />
                    </p>

                    <p class="mb-3">
                        <strong>Telefono</strong><br />
                        <asp:Label ID="lblTelefono" runat="server" />
                    </p>

                    <p class="mb-3">
                        <strong>Email</strong><br />
                        <asp:Label ID="lblEmail" runat="server" />
                    </p>

                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-header">
                    <h5 class="mb-0">Direccion de Entrega</h5>
                </div>
                <div class="card-body">
                    <asp:Label ID="lblDireccion" runat="server" />
                </div>
            </div>
        </div>

    </div>
</asp:Content>
