<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="ecommerce_web.Cart.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous" />
    <style>
        .checkout-izquierda{
            flex: 1;
            padding: 50px 80px;
        }

        .checkout-derecha{
            width: 420px;
            background:#f8f9fa;
            border-left: 1px solid #ddd;
            padding: 40px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="d-flex min-vh-100">
            <div class="checkout-izquierda flex-grow-1">
                <div class="mx-auto" style="max-width:700px;">
                    <div class="mb-5">
                        <h3 class="mb-3">Contacto</h3>

                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control mb-3" />
                        <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" placeholder="Telefono (Opcional)" />

                    </div>

                    <div class="mb-5">
                        <h4 class="mb-3">Direccion de Envio</h4>

                        <div class="d-flex gap-3 mb-3">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtNombre" />
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtApellido" />
                        </div>
                        <asp:TextBox runat="server" CssClass="form-control mb-3" placeholder="Direccion" />
                        <asp:TextBox runat="server" CssClass="form-control mb-3" placeholder="Departamento (Opcional)" />

                        <div class="d-flex gap-3 mb-3">
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Codigo Postal" />
                            
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Ciudad" />

                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Provincia" />


                        </div>
                    </div>

                    <div class="mb-5">
                        <h3 class="mb-3">Metodo de Pago</h3>

                    </div>
                </div>

            </div>

            <div class="checkout-derecha">

            </div>
        </div>
    </form>
</body>
</html>
