<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="ecommerce_web.Cart.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous" />
    <style>
        .checkout-izquierda {
            flex: 1;
            padding: 50px 80px;
        }

        .checkout-derecha {
            width: 420px;
            background: #f8f9fa;
            border-left: 1px solid #ddd;
            padding: 40px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="d-flex min-vh-100">
            <div class="checkout-izquierda flex-grow-1">
                <div class="mx-auto" style="max-width: 700px;">
                    <div class="mb-5">
                        <h3 class="mb-3">Contacto</h3>

                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control mb-3" Enabled="false" />
                        <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" placeholder="Telefono (Opcional)" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono" ValidationExpression="^\+?[0-9\s-]{7,20}$" ErrorMessage="Ingrese un numero de telefono valido." ForeColor="Red" />

                    </div>

                    <div class="mb-5">
                        <h4 class="mb-3">Direccion de Envio</h4>

                        <div class="d-flex gap-3 mb-3">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtNombre" Enabled="false" />
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtApellido" Enabled="false" />
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDni" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDni" ValidationExpression="^\d{7,8}$" ErrorMessage="Ingrese un DNI Valido." CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" CssClass="form-control mb-3" ID="txtDni" placeholder="DNI" />

                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDireccion" ErrorMessage="Campo Obligatorio" CssClass="text-danger" />
                        <asp:TextBox runat="server" CssClass="form-control mb-3" ID="txtDireccion" placeholder="Direccion" />
                        <asp:TextBox runat="server" CssClass="form-control mb-3" ID="txtDepartamento" placeholder="Departamento (Opcional)" />

                        <div class="d-flex gap-3 mb-3">
                            <div class="flex-grow-1">
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCodigoPostal" ValidationExpression="^([A-Za-z]\d{4}[A-Za-z]{3}|\d{4})$" ErrorMessage="Ingrese un Codigo Postal Valido" CssClass="text-danger" Display="Dynamic" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodigoPostal" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtCodigoPostal" placeholder="Codigo Postal" />
                            </div>

                            <div class="flex-grow-1">
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCiudad" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñ ]{2,50}$" ErrorMessage="Ingrese datos validos" CssClass="text-danger" Display="Dynamic" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCiudad" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtCiudad" placeholder="Ciudad" />
                            </div>

                            <div class="flex-grow-1">
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtProvincia" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñ ]{2,50}$" ErrorMessage="Ingrese datos validos" CssClass="text-danger" Display="Dynamic" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtProvincia" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtProvincia" placeholder="Provincia" />
                            </div>


                        </div>
                    </div>

                    <div class="mb-5">
                        <h3 class="mb-3">Metodo de Pago</h3>

                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNumeroTarjeta" ValidationExpression="^\d{13,19}$" ErrorMessage="Ingrese datos validos" CssClass="text-danger" Display="Dynamic" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNumeroTarjeta" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" ID="txtNumeroTarjeta" CssClass="form-control mb-3" placeholder="Numero de Tarjeta" />
                        <div class="d-flex gap-3 mb-3">
                            <div class="flex-grow-1">
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtVencimientoTarjeta" ValidationExpression="^(0[1-9]|1[0-2])\/\d{2}$" ErrorMessage="Ingrese datos validos" CssClass="text-danger" Display="Dynamic" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtVencimientoTarjeta" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtVencimientoTarjeta" placeholder="Fecha de vencimioento (MM/YY)" />
                            </div>
                            <div class="flex-grow-1">
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCodigoSeguridadTarjeta" ValidationExpression="^\d{3,4}$" ErrorMessage="Ingrese datos validos" CssClass="text-danger" Display="Dynamic" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodigoSeguridadTarjeta" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtCodigoSeguridadTarjeta" placeholder="Codigo de Seguridad" />
                            </div>
                        </div>
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNombreTarjeta" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñ ]{3,60}$" ErrorMessage="Ingrese datos validos" CssClass="text-danger" Display="Dynamic" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreTarjeta" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" ID="txtNombreTarjeta" CssClass="form-control mb-3" placeholder="Nombre del titular de la Tarjeta" />

                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDniTarjeta" ValidationExpression="^\d{7,8}$" ErrorMessage="Ingrese un DNI valido" CssClass="text-danger" Display="Dynamic" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDniTarjeta" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" ID="txtDniTarjeta" CssClass="form-control mb-3" placeholder="DNI del titular de la tarjeta" />

                    </div>
                    <asp:Button runat="server" ID="btnComprar" Text="Finalizar Compra" CssClass="btn btn-success btn-lg w-100" />
                </div>

            </div>

            <div class="checkout-derecha">
                <div class="d-flex flex-column h-100">
                    <asp:Repeater ID="rpResumenCarrito" runat="server">
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
                                    <div class="fw-bold">$<%# Eval("Subtotal") %></div>


                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="d-flex gap-2 mb-5">
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Codigo de Descuento" />
                        <asp:Button runat="server" Text="Aplicar" CssClass="btn btn-outline-secondary" />
                    </div>

                    <div class="mt-auto">
                        <hr />
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal</span>
                            <asp:Label ID="lblSubtotal" runat="server" />

                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span>Envio</span>
                            <asp:Label runat="server" ID="lblEnvio" />
                        </div>
                        <hr />

                        <div class="d-flex justify-content-between align-items-center">
                            <h4>Total</h4>
                            <h4>
                                <asp:Label runat="server" ID="lblTotal" /></h4>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </form>
</body>
</html>
