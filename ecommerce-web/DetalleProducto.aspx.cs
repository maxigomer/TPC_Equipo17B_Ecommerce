using System;
using negocio;
using EcommerceDominio.Catalogo;
using EcommerceDominio.Carrito;

namespace ecommerce_web
{
    public partial class DetalleProducto : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("Error404.aspx", false);
                    return;
                }

                int id = int.Parse(Request.QueryString["id"]);


                ProductoNegocio negocio = new ProductoNegocio();
                Producto producto = negocio.listar().Find(x => x.Id == id);
                Session.Add("detalleProducto", producto);

                if (producto == null)
                {
                    Response.Redirect("Error404.aspx", false);
                    return;
                }

                lblNombre.Text = producto.Nombre;
                lblDescripcion.Text = producto.Descripcion;
                lblPrecio.Text = producto.Precio.ToString();

                imgProducto.ImageUrl =
                    producto.ImagenPrincipal;
            }
        }

        protected void btnAgregarCarrito_Click(object sender, EventArgs e)
        {
            ItemCarrito item = new ItemCarrito();
            Carrito carrito = new Carrito();
            try
            {
                Producto producto = (Producto)Session["detalleProducto"];
                if (Session["carrito"] != null)
                {
                    carrito = (Carrito)Session["carrito"];
                }
                item.Precio = producto.Precio;
                item.IdProducto = producto.Id;
                item.Cantidad = int.Parse(txtCantidad.Text);

                carrito.Items.Add(item);
                Session.Add("carrito", carrito);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("~/Error404.aspx", false);
            }

        }

        protected void btnRestar_Click(object sender, EventArgs e)
        {
            if (txtCantidad.Text != "1")
            {
                txtCantidad.Text = (int.Parse(txtCantidad.Text) - 1).ToString();

            }

        }

        protected void btnSumar_Click(object sender, EventArgs e)
        {
            txtCantidad.Text = (int.Parse(txtCantidad.Text) + 1).ToString();

        }
    }
}
