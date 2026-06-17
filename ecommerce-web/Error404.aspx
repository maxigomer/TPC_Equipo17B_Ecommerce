<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Error404.aspx.cs"
    Inherits="ecommerce_web.Error404" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <title>404 - Página no encontrada</title>
</head>
<body>
    <form id="form1" runat="server">

        <div style="text-align:center; margin-top:100px;">
            <h1>404</h1>
            <h2>Página no encontrada</h2>

            <p>
                La página solicitada no existe.
            </p>

            <a href="Default.aspx">
                Volver al inicio
            </a>
        </div>

    </form>
</body>
</html>
