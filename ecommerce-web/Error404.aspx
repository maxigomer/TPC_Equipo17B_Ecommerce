<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="ecommerce_web.Error404" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error 404</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(180deg, #87CEEB 0%, #BFE9FF 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .contenedor {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card-error {
            width: 700px;
            background: white;
            border-radius: 20px;
            padding: 60px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0,0,0,.15);
        }

        .numero404 {
          font-size: 140px;
          font-weight: 900;
          line-height: 1;
          color: #0d6efd;
          text-shadow:
           4px 4px 0px #4dabf7,
           8px 8px 0px #74c0fc,
           12px 12px 25px rgba(0,0,0,.25);
}

        .titulo {
            font-size: 34px;
            font-weight: bold;
            color: #343a40;
            margin-top: 15px;
        }

        .descripcion {
            margin-top: 20px;
            font-size: 18px;
            color: #6c757d;
            line-height: 1.7;
        }

        .btn-inicio {
            margin-top: 35px;
            padding: 14px 40px;
            font-size: 18px;
            border-radius: 40px;
            font-weight: bold;
        }
    </style>

</head>
<body>

    <form id="form1" runat="server">

        <div class="contenedor">

            <div class="card-error">

                <div class="numero404">
                    404
                </div>

                <div class="titulo">
                    Pagina no encontrada
                </div>

                <div class="descripcion">
                    La pagina que estas buscando se movio, quito, renombro
                    o podria no existir nunca.
                </div>

                <asp:Button
                    ID="btnInicio"
                    runat="server"
                    Text="Volver al Inicio"
                    CssClass="btn btn-primary btn-inicio"
                    PostBackUrl="~/Default.aspx" />

            </div>

        </div>

    </form>

</body>
</html>