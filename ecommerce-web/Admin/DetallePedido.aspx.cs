using EcommerceDominio.Pedidos;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web.Admin
{
    public partial class DetallePedido : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                try
                {
                    Pedido pedido = PedidoNegocio.Listar(int.Parse(Request.QueryString["id"].ToString()));
                    rpResumenPedido.DataSource = pedido.Items;
                    rpResumenPedido.DataBind();
                    lblTotal.Text = "$" + pedido.Precio;

                }
                catch
                {
                    Response.Redirect("~/Admin/Pedidos.aspx", false);
                }
            }
            else
            {
                Response.Redirect("~/Admin/Pedidos.aspx", false);
            }

        }
    }
}