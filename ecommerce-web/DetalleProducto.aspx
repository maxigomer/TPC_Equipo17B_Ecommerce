<%@ Page Title=""
    Language="C#"
    MasterPageFile="~/MasterDesktop.Master"
    AutoEventWireup="true"
    CodeBehind="DetalleProducto.aspx.cs"
    Inherits="ecommerce_web.DetalleProducto" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="container mt-5">

        <div class="row">

            <div class="col-md-5">

                <asp:Image
                    ID="imgProducto"
                    runat="server"
                    CssClass="img-fluid rounded" />

            </div>

            <div class="col-md-7">

                <h2>
                    <asp:Label ID="lblNombre"
                        runat="server" />
                </h2>

                <h3 class="text-success">
                    $
                    <asp:Label ID="lblPrecio"
                        runat="server" />
                </h3>

                <hr />

                <p>
                    <asp:Label ID="lblDescripcion"
                        runat="server" />
                </p>

            </div>

        </div>

    </div>

</asp:Content>
