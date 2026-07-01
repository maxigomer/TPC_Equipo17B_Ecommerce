using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web
{
    public partial class Pedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Add("listaPedidos", PedidoNegocio.Listar());
                dgvPedidos.DataSource = Session["listaPedidos"];
                dgvPedidos.DataBind();

            }
        }

        protected void dgvPedidos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int id = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Id"));

                e.Row.Attributes["onclick"] = $"window.location='DetallePedido.aspx?id={id}';";

                e.Row.Style["cursor"] = "pointer";
            }

        }
    }
}