using System;
using negocio;
using EcommerceDominio.Catalogo;

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
                    Response.Redirect("Error404.aspx");
                    return;
                }

                int id = int.Parse(Request.QueryString["id"]);

                ProductoNegocio negocio = new ProductoNegocio();

                Producto producto =
                    negocio.listar().Find(x => x.Id == id);

                if (producto == null)
                {
                    Response.Redirect("Error404.aspx");
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
           Response.Write("<script>alert('Producto agregado al carrito');</script>");
        }
    }
}
