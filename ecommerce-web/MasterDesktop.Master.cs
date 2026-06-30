using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcommerceDominio.Carrito;
using negocio;

namespace ecommerce_web
{
    public partial class MasterDesktop : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ColeccionNegocio coleccionNegocio = new ColeccionNegocio();

                rpColecciones.DataSource = coleccionNegocio.listar(true);
                rpColecciones.DataBind();
            }
            if (Session["usuario"] != null)
            {
                btnLogin.Text = "Perfil";
            }

            
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (Session["carrito"] != null)
            {
                Carrito carrito = (Carrito)Session["carrito"];
                lblCantidadCarrito.Text = (carrito.Count()).ToString();
                lblCantidadCarrito.Visible = true;
            }
            else
            {
                lblCantidadCarrito.Visible = false;
            }

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Cuenta/Login.aspx", false);
        }
    }
}