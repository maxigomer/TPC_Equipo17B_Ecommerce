using EcommerceDominio.Usuarios;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web.Cuenta
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["usuario"] == null)
                {
                    Response.Redirect("~/Cuenta/Login.aspx", false);
                    return;
                }

                Usuario usuario = (Usuario)Session["usuario"];

                ClienteNegocio negocio = new ClienteNegocio();
                Cliente cliente = negocio.ObtenerPorUsuario(usuario.Id);

                if (cliente == null)
                {
                    Response.Write("NO SE ENCONTRO EL CLIENTE");
                    return;
                }

                Response.Write("Cliente encontrado: " + cliente.Nombre + " " + cliente.Apellido);
            }
        }
    }
}