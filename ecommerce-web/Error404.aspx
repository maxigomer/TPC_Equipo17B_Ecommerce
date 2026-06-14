<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="mi_ecommerce.Error404" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Página No Encontrada</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0f172a;
            color: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }
        .container { text-align: center; max-width: 600px; }
        .illustration { position: relative; width: 200px; height: 200px; margin: 0 auto 30px; }
        .circle { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); border-radius: 50%; }
        .circle-outer {
            width: 180px; height: 180px;
            background: rgba(99, 102, 241, 0.1);
            animation: pulse 3s infinite ease-in-out;
        }
        .circle-inner {
            width: 120px; height: 120px;
            background: linear-gradient(135deg, #6366f1, #a855f7);
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.4);
        }
        .error-code {
            font-size: 110px; font-weight: 800;
            line-height: 1; margin-bottom: 15px;
        }
        @keyframes pulse {
            0%,100% { transform: translate(-50%, -50%) scale(1); opacity: 0.5; }
            50% { transform: translate(-50%, -50%) scale(1.2); opacity: 0.8; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="container">
<div class="illustration">
<div class="circle circle-outer"></div>
<div class="circle circle-inner"></div>
</div>
<div class="error-code">404</div>
<h1>Página no encontrada</h1>
<p>La página que estás buscando no existe en el servidor o ha cambiado de dirección.</p>
<a href="Default.aspx">Regresar al inicio</a>
</div>
</form>
</body>
</html>