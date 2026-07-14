<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ecommerce_web.Cart.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlCarrito" runat="server">
        <div class="d-flex justify-content-between align-items-center mb-5 ms-1 pb-3 border-bottom">
            <h1 class="fw-bold display-6 mb-1">Tu Carrito</h1>

            <div class="text-end me-2">
                <div class="text-uppercase fw-semibold small">Subtotal</div>
                <div class="mb-3 fs-1 fw-bold">
                    <asp:Label ID="lblSubtotal" runat="server" />
                </div>

                <asp:Button ID="btnCheckout" runat="server" Text="Comprar" CssClass="btn btn-warning btn-lg px-5 fw-bold w-100" OnClick="btnCheckout_Click" />
            </div>
        </div>
        <asp:Repeater runat="server" ID="rpCart">
            <ItemTemplate>
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="me-4">
                                <asp:Image runat="server" ID="imgProducto" CssClass="img-fluid" Style="width: 120px;" ImageUrl='<%# Eval("Imagen") %>' />
                            </div>

                            <div class="flex-grow-1">
                                <h4 class="fw-bold mb-2">
                                    <%# Eval("Nombre") %>
                                </h4>

                                <div class="text-muted">
                                    SKU <%# Eval("SKU") %>
                                </div>

                                <div class="fw-semibold">
                                    $ <%# Eval("Precio") %>
                                </div>
                            </div>

                            <div style="width: 220px;">
                                <div class="fw-bold mb-2">
                                    Quantity
                                </div>

                                <div class="input-group">
                                    <asp:LinkButton runat="server" ID="btnRestarCantidad" CssClass="btn btn-outline-secondary" OnClick="btnRestarCantidad_Click">-</asp:LinkButton>
                                    <asp:TextBox runat="server" CssClass="form-control text-center" Text='<%# Eval("Cantidad") %>' Enabled="false" />
                                    <asp:LinkButton runat="server" ID="btnSumarCantidad" CssClass="btn btn-outline-secondary" OnClick="btnSumarCantidad_Click">+</asp:LinkButton>
                                </div>
                            </div>

                            <div class="text-end ms-5" style="width: 150px;">
                                <h4 class="mb-0">$<%# Eval("Subtotal") %></h4>
                            </div>

                            <div class="ms-4">
                                <asp:LinkButton runat="server" ID="btnEliminarItem" CssClass="btn btn-danger rounded-circle" Text="X" OnClick="btnEliminarItem_Click">
                                </asp:LinkButton>

                            </div>
                        </div>
                    </div>

                </div>


            </ItemTemplate>
        </asp:Repeater>

    </asp:Panel>

    <asp:Panel ID="pnlCarritoVacio" runat="server" Visible="false">
        <div class="text-center py-5">

            <h2>Tu carrito está vacío</h2>

            <p class="text-muted">Todavía no agregaste ningún producto.</p>

            <asp:HyperLink
                ID="lnkProductos"
                runat="server"
                NavigateUrl="~/Default.aspx"
                CssClass="btn btn-success">
            Ver productos
        </asp:HyperLink>

        </div>

    </asp:Panel>

    <div id="modalLogin" runat="server" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content bg-secondary text-white shadow">

                <div class="modal-header border-0">
                    <h3 class="modal-title w-100 text-center">Ingreso</h3>
                    <button type="button" class="btn-close btn btn-close-white" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body p-4">

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="ejemplo@email.com"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Clave</label>
                        <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>

                    <asp:Button runat="server" ID="btnLogin" Text="Ingresar" CssClass="btn btn-info w-100 fw-bold mb-2" OnClick="btnLogin_Click" />

                    <div class="text-center d-flex justify-content-center p-2 mb-3">
                        <p class="mb-0">No tenes cuenta todavia?</p>
                        <a href='<%= ResolveUrl("~/Cuenta/Register.aspx") %>' class="ps-2" style="color: black;">Crear Cuenta</a>
                    </div>

                    <asp:Label ID="lblError" runat="server" ForeColor="#FF9999" CssClass="text-center d-block"></asp:Label>
                </div>

            </div>
        </div>
    </div>


</asp:Content>
