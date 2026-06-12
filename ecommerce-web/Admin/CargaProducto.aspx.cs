using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace ecommerce_web
{
    public partial class CargaProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (!IsPostBack)
                {
                    CategoriaNegocio categoria = new CategoriaNegocio();

                    ddCategoria.DataSource = categoria.listar();
                    ddCategoria.DataValueField = "Id";
                    ddCategoria.DataTextField = "Nombre";
                    ddCategoria.DataBind();

                    ddCategoria.Items.Insert(0, "");

                }

                if (IsPostBack)
                {


                }

            }
            catch (Exception ex)
            {

            }

        }

        protected void btnAgregarCategoria_Click(object sender, EventArgs e)
        {

        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            string test = Request.Form[ddCategoria.UniqueID];

            if (test.StartsWith("NEW|"))
            {
                test = test.Substring(4);
            }

        }
    }
}