<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompraExitosa.aspx.cs" Inherits="ecommerce_web.Cart.CompraExitosa" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Compra Exitosa</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>

<form id="form1" runat="server">

<div class="container mt-5">

    <div class="card shadow text-center p-5">

        <h1 class="text-success">
            Compra realizada con exito
        </h1>

        <p class="mt-3 fs-5">
            Gracias por tu compra.
        </p>

        <p class="text-muted">
            Tu pedido fue registrado correctamente.
        </p>
        <asp:Panel ID="pnlTransferencia" runat="server" Visible="false">

    <div class="alert alert-warning mt-4 text-start">

        <h4>Datos para realizar la transferencia</h4>

        <hr />

        <p>
            <strong>Alias:</strong> PacheTech.PT
        </p>

        <p>
            <strong>CVU:</strong> 7482913100007483097815
        </p>

        <p>
            <strong>Banco:</strong> Banco Nación
        </p>

        <p>
            <strong>Titular:</strong> PacheTech SA
        </p>

        <p class="mb-0">
            Una vez realizada la transferencia, envíanos el comprobante para confirmar tu pedido.
        </p>

    </div>

</asp:Panel>

        <asp:Button
            ID="btnInicio"
            runat="server"
            Text="Volver al Inicio"
            CssClass="btn btn-primary mt-4"
            OnClick="btnInicio_Click"/>

    </div>

</div>

</form>

</body>
</html>