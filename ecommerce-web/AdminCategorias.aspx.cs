using EcommerceDominio;
using EcommerceDominio.Catalogo;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace ecommerce_web
{
    public partial class AdminCategorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarGrilla();
            }
        }

        private void cargarGrilla()
        {
            CategoriaNegocio negocio = new CategoriaNegocio();
            dgvCategorias.DataSource = negocio.listar();
            dgvCategorias.DataBind();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Categoria nueva = new Categoria();
                nueva.Nombre = txtNombreCategoria.Text;

                CategoriaNegocio negocio = new CategoriaNegocio();
                negocio.agregarConSP(nueva);

                txtNombreCategoria.Text = "";
                cargarGrilla();
            }
        }
    }
}