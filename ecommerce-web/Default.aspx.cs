using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using EcommerceDominio.Catalogo;
using EcommerceDominio.Carrito;

namespace ecommerce_web
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //continuación de consulta con base de datos para la carga de produtos
                ProductoNegocio negocio = new ProductoNegocio();

                try
                {
                    List<Producto> lista = negocio.listarActivos();

                    string buscar = Request.QueryString["buscar"];

                    if (!string.IsNullOrWhiteSpace(buscar))
                    {
                        lista = lista.Where(x =>
                            x.Nombre.ToLower().Contains(buscar.ToLower())
                        ).ToList();
                    }

                    Session["listaProductos"] = lista;
                    rptProductos.DataSource = lista;
                    rptProductos.DataBind();
                    
                   //imgBanner.ImageUrl = BannerNegocio.Url();
                    /*Session.Add("listaProductos", negocio.listarActivos());
                    rptProductos.DataSource = (List<Producto>)Session["listaProductos"];
                    rptProductos.DataBind();
                    imgBanner.ImageUrl = BannerNegocio.Url();*/

                }
                catch
                {

                }
            }
        }

        protected void btnAgregarCarrito_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int id = int.Parse(btn.CommandArgument.ToString());


            ItemCarrito item = new ItemCarrito();
            Carrito carrito = new Carrito();
            try
            {
                Producto producto = ((List<Producto>)Session["listaProductos"]).Find(x => x.Id == id);
                if (Session["carrito"] != null)
                {
                    carrito = (Carrito)Session["carrito"];
                }
                item.Precio = producto.Precio;
                item.IdProducto = producto.Id;
                item.Cantidad = 1;
                item.Imagen = producto.ImagenPrincipal;
                item.Nombre = producto.Nombre;
                item.Sku = producto.Sku;

                carrito.Items.Add(item);
                Session.Add("carrito", carrito);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("~/Error404.aspx", false);
            }
        }
    }
}