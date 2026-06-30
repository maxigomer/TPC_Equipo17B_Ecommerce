<%@ Page Title="" Language="C#" MasterPageFile="~/MasterDesktop.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ecommerce_web.Cart.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Repeater runat="server" ID="rpCart">
        <ItemTemplate>
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="me-4">
                            <asp:Image runat="server" ID="imgProducto" CssClass="img-fluid" Style="width: 120px;" ImageUrl='<%# Eval("Imagen") %>' />
                        </div>

                        <div class="flex-grow-1">
                            <h4 class="fw-bold mb-2">
                                <%# Eval("Nombre") %>
                            </h4>

                            <div class="text-muted">
                                SKU <%# Eval("SKU") %>
                            </div>

                            <div class="fw-semibold">
                                $ <%# Eval("Precio") %>
                            </div>
                        </div>

                        <div style="width: 220px;">
                            <div class="fw-bold mb-2">
                                Quantity
                            </div>

                            <div class="input-group">
                                <asp:LinkButton runat="server" ID="btnRestarCantidad" CssClass="btn btn-outline-secondary" OnClick="btnRestarCantidad_Click" >-</asp:LinkButton>
                                <asp:TextBox runat="server" CssClass="form-control text-center" Text='<%# Eval("Cantidad") %>' />
                                <asp:LinkButton runat="server" ID="btnSumarCantidad" CssClass="btn btn-outline-secondary" OnClick="btnSumarCantidad_Click">+</asp:LinkButton>
                            </div>
                        </div>

                        <div class="text-end ms-5" style="width: 150px;">
                            <h4 class="mb-0">$<%# Eval("Subtotal") %></h4>
                        </div>

                        <div class="ms-4">
                            <asp:LinkButton runat="server" ID="btnEliminarItem" CssClass="btn btn-danger rounded-circle" Text="X" OnClick="btnEliminarItem_Click">
                            </asp:LinkButton>

                        </div>
                    </div>
                </div>

            </div>


        </ItemTemplate>
    </asp:Repeater>

</asp:Content>
