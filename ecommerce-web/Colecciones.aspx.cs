using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace ecommerce_web
{
    public partial class Colecciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductoNegocio negocio = new ProductoNegocio();
                try
                {
                    if (Request.QueryString["id"] != null && Request.QueryString["criterio"] != null)
                    {
                        rptProductos.DataSource = negocio.listarActivos(Request.QueryString["criterio"], int.Parse(Request.QueryString["id"]));
                        rptProductos.DataBind();

                    }
                    else
                    {
                        rptProductos.DataSource = negocio.listarActivos();
                        rptProductos.DataBind();
                    }

                }
                catch (Exception ex)
                {
                    Session.Add("error", ex);
                    Response.Redirect("Error404.aspx", false);
                }

            }


        }
    }
}