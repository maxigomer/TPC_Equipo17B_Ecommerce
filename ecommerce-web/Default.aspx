<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ecommerce_web.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<h2>Listado de productos</h2>--%>
    
    <div class="container my-5">
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
                            
                            <h4 class="text-primary font-weight-bold mt-2">
                                $<%# Eval("Precio", "{0:N2}") %>
                            </h4>
                        </div>

                        <div class="card-footer bg-transparent border-top-0 p-3">
                            <div class="d-grid gap-2">
                                <a href='Carrito.aspx?idProducto=<%# Eval("Id") %>' class="btn btn-success">
                                    <i class="bi bi-cart-plus"></i> Agregar al carrito
                                </a>
                                <a href='DetalleProducto.aspx?id=<%# Eval("Id") %>' class="btn btn-outline-secondary btn-sm">
                                    Ver detalle
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</div>
    
</asp:Content>
