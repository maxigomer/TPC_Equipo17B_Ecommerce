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

                <h3 class="text-success">$
                <asp:Label ID="lblPrecio" runat="server" />
                </h3>

                <div class="d-flex align-items-center gap-3">

                    <div class="input-group" style="width: 120px;">
                        <asp:LinkButton ID="btnRestar" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnRestar_Click">-</asp:LinkButton>
                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control text-center" Text="1" ReadOnly="true" />
                        <asp:LinkButton ID="btnSumar" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnSumar_Click">+</asp:LinkButton>

                    </div>
                    <div class="d-flex align-items-center justify-content-center">
                        <asp:Button ID="btnAgregarCarrito"
                            runat="server"
                            Text="Agregar al carrito"
                            CssClass="btn btn-success"
                            OnClick="btnAgregarCarrito_Click" />


                    </div>

                </div>

                <hr />

                <p>
                    <asp:Label ID="lblDescripcion"
                        runat="server" />
                </p>

            </div>

        </div>

    </div>

</asp:Content>
