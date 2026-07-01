using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcommerceDominio.Usuarios;

namespace ecommerce_web
{
    public partial class MasterDesktopAdmin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                Usuario usuario = (Usuario)Session["usuario"];

                if(usuario.Rol.Id != 1)
                {
                    Response.Redirect("~/Default.aspx",false);
                }

            }
            else
            {
                //Response.Redirect("~/Default.aspx", false);
            }

        }

         protected void btnBuscar_Click(object sender, EventArgs e)
        {
         Response.Redirect("Productos.aspx?buscar=" + txtBuscar.Text);
        }
    }
}
