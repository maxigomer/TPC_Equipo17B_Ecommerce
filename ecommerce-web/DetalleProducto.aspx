<<<<<<< HEAD
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master"
AutoEventWireup="true" CodeBehind="DetalleProducto.aspx.cs"
Inherits="ecommerce_web.DetalleProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container my-5">

    <asp:Panel ID="pnlDetalle" runat="server" Visible="false">

        <div class="row">

            <!-- IMÁGENES -->
            <div class="col-md-6">
                <asp:Repeater ID="rptImagenes" runat="server">
                    <ItemTemplate>
                        <img src='<%# Eval("Url") %>' class="img-fluid mb-2" />
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- INFO -->
            <div class="col-md-6">

                <h2>
                    <asp:Label ID="lblNombre" runat="server" />
                </h2>

                <p>
                    <asp:Label ID="lblDescripcion" runat="server" />
                </p>

                <h3 class="text-primary">
                    $<asp:Label ID="lblPrecio" runat="server" />
                </h3>

                <p>
                    <b>Marca:</b> <asp:Label ID="lblMarca" runat="server" /><br />
                    <b>Categoría:</b> <asp:Label ID="lblCategoria" runat="server" />
                </p>

                <asp:Button ID="btnAgregar" runat="server"
                    Text="Agregar al carrito"
                    CssClass="btn btn-success" />

            </div>

        </div>

    </asp:Panel>

</div>

=======
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master"
AutoEventWireup="true" CodeBehind="DetalleProducto.aspx.cs"
Inherits="ecommerce_web.DetalleProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container my-5">

    <asp:Panel ID="pnlDetalle" runat="server" Visible="false">

        <div class="row">

            <!-- IMÁGENES -->
            <div class="col-md-6">
                <asp:Repeater ID="rptImagenes" runat="server">
                    <ItemTemplate>
                        <img src='<%# Eval("Url") %>' class="img-fluid mb-2" />
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- INFO -->
            <div class="col-md-6">

                <h2>
                    <asp:Label ID="lblNombre" runat="server" />
                </h2>

                <p>
                    <asp:Label ID="lblDescripcion" runat="server" />
                </p>

                <h3 class="text-primary">
                    $<asp:Label ID="lblPrecio" runat="server" />
                </h3>

                <p>
                    <b>Marca:</b> <asp:Label ID="lblMarca" runat="server" /><br />
                    <b>Categoría:</b> <asp:Label ID="lblCategoria" runat="server" />
                </p>

                <asp:Button ID="btnAgregar" runat="server"
                    Text="Agregar al carrito"
                    CssClass="btn btn-success" />

            </div>

        </div>

    </asp:Panel>

</div>

>>>>>>> 36bb2dccb1604ef3c2e70dfabb42bd1642b39ac7
</asp:Content>