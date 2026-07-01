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
                if (Session["carrito"] != null)
                {

                    Carrito carrito = (Carrito)Session["carrito"];
                    if (carrito.Items.Count < 1)
                    {
                        pnlCarrito.Visible = false;
                        pnlCarritoVacio.Visible = true;

                    }
                    else
                    {
                        rpCart.DataSource = carrito.Items;
                        rpCart.DataBind();
                        pnlCarrito.Visible = true;
                        pnlCarritoVacio.Visible = false;
                        lblSubtotal.Text = "$" + (carrito.GetTotal()).ToString();

                    }

                }
                else
                {
                    pnlCarrito.Visible = false;
                    pnlCarritoVacio.Visible = true;
                }

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

        protected void btnEliminarItem_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Carrito carrito = (Carrito)Session["carrito"];

            try
            {
                carrito.Items.RemoveAt(item.ItemIndex);
            }
            catch
            {

            }

        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                Response.Redirect("~/Cart/Checkout.aspx", false);
            }
            else
            {
                
            }
        }
    }
}