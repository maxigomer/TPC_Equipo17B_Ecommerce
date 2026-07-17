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
                Cliente cliente = UsuarioNegocio.GetCliente(usuario.Id);

                //ClienteNegocio negocio = new ClienteNegocio();

                //Cliente cliente = negocio.ObtenerPorUsuario(usuario.Id);

                if (cliente != null)
                {
                    txtNombre.Text = cliente.Nombre;
                    txtApellido.Text = cliente.Apellido;
                    txtDNI.Text = cliente.DNI;
                    txtEmail.Text = cliente.Email;
                    txtTelefono.Text = cliente.Telefono;

                    if (string.IsNullOrWhiteSpace(cliente.DNI))
                    {
                        lblDni.Text = "Todavía no registraste tu DNI.";
                    }

                    ActualizarDdlDirecciones();
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

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/Default.aspx", false);
        }

        protected void ddlDirecciones_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idDireccion = int.Parse(ddlDirecciones.SelectedValue);

            if (idDireccion == 0)
            {

                txtCalle.Text = "";
                txtCodigoPostal.Text = "";
                txtLocalidad.Text = "";
                txtNumeroCalle.Text = "";
                txtObservaciones.Text = "";
                btnGuardarDireccion.Text = "Guardar Direccion";
                btnEliminarDireccion.Visible = false;

            }
            else
            {
                Direccion direccion = DireccionNegocio.Listar(idDireccion);

                txtCalle.Text = direccion.Calle;
                txtCodigoPostal.Text = direccion.CodigoPostal;
                txtLocalidad.Text = direccion.Localidad;
                txtNumeroCalle.Text = direccion.Numero.ToString();
                txtObservaciones.Text = direccion.Observaciones;
                btnGuardarDireccion.Text = "Modificar Direccion";
                btnEliminarDireccion.Visible = true;

            }

        }

        protected void btnGuardarDireccion_Click(object sender, EventArgs e)
        {
            Direccion direccion = new Direccion();
            Usuario usuario = (Usuario)Session["usuario"];
            Cliente cliente = UsuarioNegocio.GetCliente(usuario.Id);
            int idDireccion = int.Parse(ddlDirecciones.SelectedValue);

            if (idDireccion == 0)
            {
                direccion.Calle = txtCalle.Text;
                direccion.CodigoPostal = txtCodigoPostal.Text;
                direccion.Localidad = txtLocalidad.Text;
                direccion.Numero = int.Parse(txtNumeroCalle.Text);
                direccion.Observaciones = txtObservaciones.Text;

                DireccionNegocio.Agregar(cliente.Id, direccion);

            }
            else
            {
                direccion.Calle = txtCalle.Text;
                direccion.CodigoPostal = txtCodigoPostal.Text;
                direccion.Localidad = txtLocalidad.Text;
                direccion.Numero = int.Parse(txtNumeroCalle.Text);
                direccion.Observaciones = txtObservaciones.Text;
                direccion.Id = idDireccion;
                DireccionNegocio.Modificar(direccion);

            }
            ActualizarDdlDirecciones();



        }

        protected void btnEliminarDireccion_Click(object sender, EventArgs e)
        {
            int idDireccion = int.Parse(ddlDirecciones.SelectedValue);
            DireccionNegocio.Eliminar(idDireccion);
            ActualizarDdlDirecciones();


        }

        protected void ActualizarDdlDirecciones()
        {
            Usuario usuario = (Usuario)Session["usuario"];
            Cliente cliente = UsuarioNegocio.GetCliente(usuario.Id);

            if (cliente.Direcciones.Count() > 0)
            {
                cliente = UsuarioNegocio.GetCliente(usuario.Id);
                ddlDirecciones.DataSource = cliente.Direcciones;
                ddlDirecciones.DataValueField = "Id";
                ddlDirecciones.DataTextField = "DireccionCompleta";
                ddlDirecciones.DataBind();

                txtCalle.Text = "";
                txtCodigoPostal.Text = "";
                txtLocalidad.Text = "";
                txtNumeroCalle.Text = "";
                txtObservaciones.Text = "";
                btnGuardarDireccion.Text = "Guardar Direccion";
            }
            ddlDirecciones.Items.Insert(0, new ListItem("Nueva direccion", "0"));

        }
    }
}