using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLoginAcceder_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text == "admin@mail.com" && txtPassword.Text == "admin")
            {
                Session["AdminLogueado"] = true;
                Response.Redirect("Productos.aspx", false);
            }
            else
            {
                lblError.Text = "Credenciales incorrectas. Verifique y vuelva a intentar.";
            }
        }
    }
}