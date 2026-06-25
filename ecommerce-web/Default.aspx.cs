using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace ecommerce_web
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //continuación de consulta con base de datos para la carga de produtos
                ProductoNegocio negocio = new ProductoNegocio();

                rptProductos.DataSource = negocio.listarActivos();
                rptProductos.DataBind();
                imgBanner.ImageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPDg0Tnc6LbsdSr6DaEyTxaNlyKWiEAt5v0Z7lc7ZnZXvNtDHK7CZ_kSbd&s=10";
            }
        }
    }
}