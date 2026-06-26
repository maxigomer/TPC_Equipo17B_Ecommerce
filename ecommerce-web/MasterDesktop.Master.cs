using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
            
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cuenta/Login.aspx", false);
        }
    }
}