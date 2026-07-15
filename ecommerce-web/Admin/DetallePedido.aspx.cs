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
                    ClienteNegocio clienteNegocio = new ClienteNegocio();
                    Pedido pedido = PedidoNegocio.Listar(int.Parse(Request.QueryString["id"].ToString()));
                    rpResumenPedido.DataSource = pedido.Items;
                    rpResumenPedido.DataBind();
                    lblTotal.Text = "$" + pedido.Precio;
                    pedido.Cliente = clienteNegocio.ObtenerPorUsuario(pedido.Cliente.Id);
                    lblNombre.Text = pedido.Cliente.NombreCompleto;
                    lblEmail.Text = pedido.Cliente.Email;
                    lblTelefono.Text = pedido.Cliente.Telefono;


                    if (pedido.Direccion.Id == -1)
                    {
                        lblDireccion.Text = "Cliente retira en el local";

                    }
                    else
                    {
                        pedido.Direccion = DireccionNegocio.Listar(pedido.Direccion.Id);
                        lblDireccion.Text = pedido.Direccion.DireccionCompleta;

                    }


                    PedidoNegocio.ListarObservaciones(pedido);
                    if (pedido.Observaciones.Count() > 0)
                    {
                        pnlObservacionesVacias.Visible = false;
                        pnlObservaciones.Visible = true;
                        rpObservaciones.DataSource = pedido.Observaciones;
                        rpObservaciones.DataBind();

                    }
                    else
                    {
                        pnlObservacionesVacias.Visible = true;
                        pnlObservaciones.Visible = false;
                    }


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

        protected void Page_PreRender(object sender, EventArgs e)
        {

            Pedido pedido = PedidoNegocio.Listar(int.Parse(Request.QueryString["id"].ToString()));
            PedidoNegocio.ListarObservaciones(pedido);
            if (pedido.Observaciones.Count() > 0)
            {
                pnlObservacionesVacias.Visible = false;
                pnlObservaciones.Visible = true;
                rpObservaciones.DataSource = pedido.Observaciones;
                rpObservaciones.DataBind();

            }
            else
            {
                pnlObservacionesVacias.Visible = true;
                pnlObservaciones.Visible = false;
            }

        }


        protected void btnGuardarObservacion_Click(object sender, EventArgs e)
        {
            ObservacionPedido obs = new ObservacionPedido();
            obs.IdPedido = int.Parse(Request.QueryString["id"].ToString());
            obs.Observacion = txtObservaciones.Text;
            PedidoNegocio.AgregarObservacion(obs);

        }
    }
}