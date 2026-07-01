using System;
using System.Web.UI;

namespace ecommerce_web.Cart
{
    public partial class CompraExitosa : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx", false);
        }
    }
}