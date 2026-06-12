using System;

namespace TuProyecto
{
    public partial class Error404 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Forzar al navegador y motores de búsqueda a recibir el código 404 real
            Response.StatusCode = 404;
            Response.StatusDescription = "Page not found";
        }
    }
}
