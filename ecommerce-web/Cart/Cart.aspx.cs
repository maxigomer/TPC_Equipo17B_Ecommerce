using EcommerceDominio.Carrito;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web.Cart
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }

        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            try
            {
                Carrito carrito = (Carrito)Session["carrito"];
                rpCart.DataSource = carrito.Items;
                rpCart.DataBind();

            }
            catch (Exception ex)
            {

            }

        }

        protected void btnSumarCantidad_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Carrito carrito = (Carrito)Session["carrito"];

            carrito.Items[item.ItemIndex].Cantidad++;

        }

        protected void btnRestarCantidad_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Carrito carrito = (Carrito)Session["carrito"];

            if (carrito.Items[item.ItemIndex].Cantidad > 1)
                carrito.Items[item.ItemIndex].Cantidad--;

        }
    }
}