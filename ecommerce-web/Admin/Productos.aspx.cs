using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web
{
    public partial class Productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductoNegocio negocio = new ProductoNegocio();
                Session.Add("listaProductos", negocio.listar());
                dgvProductos.DataSource = Session["listaProductos"];
                dgvProductos.DataBind();



                //ImagenNegocio imagen = new ImagenNegocio();
                //Session.Add("listaImagenes", imagen.listar());
                //dgvTest.DataSource = Session["listaImagenes"];
                //dgvTest.DataBind();


            }

           
        }
        protected void btnCargaProducto_Click(object sender, EventArgs e)
        {

            Response.Redirect("CargaProducto.aspx", false);
        }

        protected void dgvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {

            string id = dgvProductos.SelectedDataKey.Value.ToString();
            Response.Redirect("CargaProducto.aspx?=" + id, false);
        }
    }
}