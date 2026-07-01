using EcommerceDominio.Usuarios;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web.Cuenta
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["usuario"] == null)
                {
                    Response.Redirect("~/Cuenta/Login.aspx", false);
                    return;
                }

                Usuario usuario = (Usuario)Session["usuario"];

                ClienteNegocio negocio = new ClienteNegocio();

                Cliente cliente = negocio.ObtenerPorUsuario(usuario.Id);

                if (cliente != null)
                {
                    txtNombre.Text = cliente.Nombre;
                    txtApellido.Text = cliente.Apellido;
                    txtDNI.Text = cliente.DNI;
                    txtEmail.Text = cliente.Email;
                    txtTelefono.Text = cliente.Telefono;
                }
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("~/Cuenta/Login.aspx", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtApellido.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblMensaje.Text = "Complete los campos obligatorios.";
                lblMensaje.CssClass = "text-danger";
                return;
            }

            Usuario usuario = (Usuario)Session["usuario"];

            Cliente cliente = new Cliente
            {
                Nombre = txtNombre.Text.Trim(),
                Apellido = txtApellido.Text.Trim(),
                DNI = txtDNI.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                Telefono = txtTelefono.Text.Trim()
            };

            cliente.Usuario.Id = usuario.Id;

            ClienteNegocio negocio = new ClienteNegocio();
            negocio.Modificar(cliente);

            lblMensaje.Text = "Perfil actualizado correctamente.";
            lblMensaje.CssClass = "text-success";
        }
    }
}