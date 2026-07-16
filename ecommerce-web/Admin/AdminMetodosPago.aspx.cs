using EcommerceDominio.Parametros;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web.Admin
{
    public partial class AdminMetodosPago : System.Web.UI.Page
    {
        private MetodoPagoNegocio negocio = new MetodoPagoNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarGrilla();
            }
        }

        private void cargarGrilla()
        {
            dgvMetodos.DataSource = negocio.Listar();
            dgvMetodos.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                MetodoPago metodo = new MetodoPago();
                metodo.Nombre = txtNombre.Text;

                if (string.IsNullOrEmpty(hfIdEditando.Value))
                {
                    // Alta
                    negocio.Agregar(metodo);
                }
                else
                {
                    // Modificación
                    metodo.Id = int.Parse(hfIdEditando.Value);
                    negocio.Modificar(metodo);
                }

                limpiarFormulario();
                cargarGrilla();
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            limpiarFormulario();
        }

        private void limpiarFormulario()
        {
            txtNombre.Text = "";
            hfIdEditando.Value = "";
            lblFormulario.Text = "Nuevo Método de Pago";
            btnCancelar.Visible = false;
        }

        protected void dgvMetodos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                MetodoPago metodo = negocio.Listar().FirstOrDefault(m => m.Id == id);
                if (metodo != null)
                {
                    txtNombre.Text = metodo.Nombre;
                    hfIdEditando.Value = metodo.Id.ToString();
                    lblFormulario.Text = "Modificando Método ID " + id;
                    btnCancelar.Visible = true;
                }
            }
            else if (e.CommandName == "CambiarEstado")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int id = int.Parse(args[0]);
                bool estadoActual = bool.Parse(args[1]);
                
                negocio.EliminarLogico(id, !estadoActual);
                cargarGrilla();
            }
        }
    }
}
