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
        <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
        <div class="d-flex min-vh-100">
            <div class="checkout-izquierda flex-grow-1">
                <div class="mx-auto" style="max-width: 700px;">
                    <div class="mb-5">
                        <h3 class="mb-3">Contacto</h3>

                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control mb-3" Enabled="false" />
                        <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" placeholder="Telefono (Opcional)" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono" ValidationExpression="^\+?[0-9\s-]{7,20}$" ErrorMessage="Ingrese un numero de telefono valido." ForeColor="Red" />

                        <div class="d-flex gap-3 mb-3">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtNombre" Enabled="false" />
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtApellido" Enabled="false" />
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDni" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDni" ValidationExpression="^\d{7,8}$" ErrorMessage="Ingrese un DNI Valido." CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" CssClass="form-control mb-3" ID="txtDni" placeholder="DNI" />
                    </div>

                    <div class="mb-5">
                        <h4 class="mb-3">Metodo de Entrega</h4>

                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>

                                <asp:CustomValidator runat="server" ID="cvMetodoEntrega" ErrorMessage="Debe seleccionar un metodo de entrega" CssClass="text-danger"
                                    display="Dynamic"  OnServerValidate="cvMetodoEntrega_ServerValidate" ClientValidationFunction="validarMetodoEntrega" />

                                <div class="card shadow-sm mb-3 p-3">
                                    <div class="form-check">
                                        <asp:RadioButton runat="server" ID="rbEnvio" GroupName="MetodoEntrega" AutoPostBack="true" OnCheckedChanged="MetodoEntrega_CheckedChanged" />
                                        <label class="form-check-label fw-semibold" for="<%= rbEnvio.ClientID %>">Envio a Domicilio</label>
                                    </div>
                                </div>

                                <div class="card shadow-sm mb-3 p-3">
                                    <div class="form-check">
                                        <asp:RadioButton runat="server" ID="rbRetirarLocal" GroupName="MetodoEntrega" AutoPostBack="true" OnCheckedChanged="MetodoEntrega_CheckedChanged" />
                                        <label class="form-check-label fw-semibold" for="<%= rbRetirarLocal.ClientID %>">Retirar por Sucursal</label>
                                    </div>
                                </div>

                                <asp:Panel ID="pnlEnvio" runat="server" Visible="false">
                                    <div class="card bg-light shadow-sm border-0 p-4 mb-3">
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

                                    </div>
                                </asp:Panel>

                                <asp:Panel ID="pnlRetirarLocal" runat="server" Visible="false">
                                    <div class="card bg-light shadow-sm border-0 p-4 mb-3">
                                        <h6>Retiras en Casa Central</h6>
                                        <p>Avenida Santa Maria de las Conchas 4055, Rincon de Milberg, Tigre, Buenos Aires, 1648</p>
                                        <ul>
                                            <li>Lunes a Viernes, de 10:00 a 18:00</li>
                                        </ul>
                                        
                                    </div>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>


                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtObservaciones" ValidationExpression="^.{0,150}$" ErrorMessage="Las observaciones no pueden superar 150 caracteres" CssClass="text-danger" Display="Dynamic" />
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtObservaciones" placeholder="Observaciones (Opcional)" TextMode="MultiLine" Rows="5" />
                    </div>

                    <div class="mb-5">
                        <h3 class="mb-3">Metodo de Pago</h3>

                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>

                                <asp:CustomValidator runat="server" ID="cvMetodoPago" ErrorMessage="Debe seleccionar un metodo de pago" CssClass="text-danger"
                                    display="Dynamic"  OnServerValidate="cvMetodoPago_ServerValidate" ClientValidationFunction="validarMetodoPago" />

                                <div class="card shadow-sm mb-3 p-3">
                                    <div class="form-check">
                                        <asp:RadioButton runat="server" ID="rbTarjeta" GroupName="MetodoPago" AutoPostBack="true" OnCheckedChanged="MetodoPago_CheckedChanged" />
                                        <label class="form-check-label fw-semibold" for="<%= rbTarjeta.ClientID %>">Tarjeta de Credito/Debito</label>
                                    </div>
                                </div>

                                <div class="card shadow-sm mb-3 p-3">
                                    <div class="form-check">
                                        <asp:RadioButton runat="server" ID="rbTransferencia" GroupName="MetodoPago" AutoPostBack="true" OnCheckedChanged="MetodoPago_CheckedChanged" />
                                        <label class="form-check-label fw-semibold" for="<%= rbTransferencia.ClientID %>">Transferencia Bancaria</label>
                                    </div>
                                </div>

                                <asp:Panel ID="pnlTarjeta" runat="server" Visible="false">
                                    <div class="card bg-light shadow-sm border-0 p-4 mb-3">
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

                                </asp:Panel>

                                <asp:Panel ID="pnlTransferencia" runat="server" Visible="false">
                                    <div class="card bg-light shadow-sm border-0 p-4 mb-3">
                                        <label class="mb-3">Ingrese el numero de documento del titular de la cuenta desde la que se va a realizar la transferencia.</label>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDniTransferencia" ErrorMessage="Campo Obligatorio" CssClass="text-danger" Display="Dynamic" />
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDniTransferencia" ValidationExpression="^\d{7,8}$" ErrorMessage="Ingrese un DNI Valido." CssClass="text-danger" Display="Dynamic" />
                                        <asp:TextBox runat="server" CssClass="form-control mb-3" ID="txtDniTransferencia" placeholder="DNI" />
                                        <p class="mb-0 text-muted">Una vez finalizada la compra vas a recibir los datos necesarios para realizar la transferencia</p>

                                    </div>

                                </asp:Panel>

                            </ContentTemplate>
                        </asp:UpdatePanel>


                    </div>
                    <asp:Button runat="server" ID="btnComprar" Text="Finalizar Compra" CssClass="btn btn-success btn-lg w-100" OnClick="btnComprar_Click" />
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
