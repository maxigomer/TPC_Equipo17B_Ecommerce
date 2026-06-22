<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ecommerce_web.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- <div class="bg-dark text-white text-center p-5 rounded mb-4">
        <h1>Bienvenido a la tienda</h1>
        <p>Encontrá ofertas en todos los productos</p>
    </div>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<h2>Listado de productos</h2>--%>

    <%--<div class="container my-5">
        <h2 class="mb-4 text-center">Nuestro Catálogo de Productos</h2>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">

            <asp:Repeater ID="rptProductos" runat="server">
                <ItemTemplate>
                    <div class="col">
                        <div class="card h-100 shadow-sm hover-card">

                            <img src='<%# Eval("UrlImagenPrincipal") ?? "/img/no-image.png" %>' class="card-img-top" alt='<%# Eval("Nombre") %>' style="height: 200px; object-fit: cover;">

                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title text-dark"><%# Eval("Nombre") %></h5>

                                <p class="card-text text-muted small flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                    <%# Eval("Descripcion") %>
                                </p>

                                <h4 class="text-primary font-weight-bold mt-2">$<%# Eval("Precio", "{0:N2}") %>
                                </h4>
                            </div>

                            <div class="card-footer bg-transparent border-top-0 p-3">
                                <div class="d-grid gap-2">
                                    <a href='Carrito.aspx?idProducto=<%# Eval("Id") %>' class="btn btn-success">
                                        <i class="bi bi-cart-plus"></i>Agregar al carrito
                                    </a>
                                    <a href='DetalleProducto.aspx?id=<%# Eval("Id") %>' class="btn btn-outline-secondary btn-sm">Ver detalle
                                    </a>
                                </div>
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>--%>

<%--    posible banner--%>

<%--    <div class="carousel slide mb-6" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item">
                <img src="https://www.antevenio.com/wp-content/uploads/2016/04/20-ejemplos-de-banners-creativos.jpg" />
            </div>
            <div class="carousel-item">
                <img src="https://alexcastrovalin.com/wp-content/uploads/2019/11/que-es-un-banner-en-marketing-y-tipos-de-banners-con-ejemplos.jpg" />
            </div>

        </div>

    </div>--%>

    <div class="container my-5">
        <h2 class="mb-4 text-center">Nuestro Catálogo</h2>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">

            <asp:Repeater ID="rptProductos" runat="server">
                <ItemTemplate>
                    <div class="col">
                        <div class="card h-100 shadow-sm hover-card">

                            <div id='carousel-<%# Eval("Id") %>' class="carousel slide" data-bs-ride="false">
                                <div class="carousel-inner">

                                    <asp:Repeater ID="rptImagenes" runat="server" DataSource='<%# Eval("Imagenes") %>'>
                                        <ItemTemplate>
                                            <div class='carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>'>
                                                <img src='<%# Eval("Url") %>' class="d-block w-100 card-img-top" alt="Foto del producto" style="height: 200px; object-fit: cover;">
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                </div>

                                <button class="carousel-control-prev" type="button" data-bs-target='#carousel-<%# Eval("Id") %>' data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Anterior</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target='#carousel-<%# Eval("Id") %>' data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">Siguiente</span>
                                </button>
                            </div>

                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title text-dark"><%# Eval("Nombre") %></h5>

                                <p class="card-text text-muted small flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                    <%# Eval("Descripcion") %>
                                </p>

                                <h4 class="text-primary fw-bold mt-2">$<%# Eval("Precio", "{0:N2}") %>
                                </h4>
                            </div>

                            <div class="card-footer bg-transparent border-top-0 p-3">
                                <div class="d-grid gap-2">
                                    <a href='Carrito.aspx?idProducto=<%# Eval("Id") %>' class="btn btn-success">
                                        <i class="bi bi-cart-plus"></i>Agregar al carrito
                                    </a>
                                    <a href='DetalleProducto.aspx?id=<%# Eval("Id") %>' class="btn btn-outline-secondary btn-sm">Ver detalle
                                    </a>
                                </div>
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>
    s

</asp:Content>
