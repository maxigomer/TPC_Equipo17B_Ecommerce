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
                CargarPedidos();
            }
        }


        private void CargarPedidos()
        {
            Session.Add("listaPedidos", PedidoNegocio.Listar());

            dgvPedidos.DataSource = Session["listaPedidos"];
            dgvPedidos.DataBind();
        }



        protected void dgvPedidos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int id = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Id"));


                e.Row.Attributes["onclick"] =
                    $"window.location='DetallePedido.aspx?id={id}';";


                e.Row.Style["cursor"] = "pointer";

                DropDownList ddlEstado =
                    (DropDownList)e.Row.FindControl("ddlEstado");


                if (ddlEstado != null)
                {
                    ddlEstado.DataSource = PedidoNegocio.ListarEstados();
                    ddlEstado.DataTextField = "Estado";
                    ddlEstado.DataValueField = "Id";
                    ddlEstado.DataBind();


                    int estadoActual =
                        Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "IdEstado"));


                    ddlEstado.SelectedValue = estadoActual.ToString();
                }
            }
        }

        protected void dgvPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CambiarEstado")
            {

                int idPedido = Convert.ToInt32(e.CommandArgument);


                Button btn = (Button)e.CommandSource;


                GridViewRow fila = (GridViewRow)btn.NamingContainer;


                DropDownList ddlEstado = (DropDownList)fila.FindControl("ddlEstado");


                int nuevoEstado =
                    Convert.ToInt32(ddlEstado.SelectedValue);



                PedidoNegocio.CambiarEstado(
                    idPedido,
                    nuevoEstado
                );

                CargarPedidos();
            }
        }

    }
}