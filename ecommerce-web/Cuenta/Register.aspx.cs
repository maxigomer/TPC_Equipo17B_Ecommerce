using negocio;
using EcommerceDominio.Usuarios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web.Cuenta
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] != null)
            {
                Response.Redirect("~/Default.aspx", false);
            }

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Cliente cliente = new Cliente();

            try
            {
                if (!Page.IsValid)
                {
                    return;
                }

                cliente.Nombre = txtNombre.Text;
                cliente.Apellido = txtApellido.Text;
                cliente.Email = txtEmail.Text;
                cliente.Usuario.NombreUsuario = txtEmail.Text;
                cliente.Telefono = txtTelefono.Text;

                if (txtPassword.Text == txtConfirmarPassword.Text)
                {
                    cliente.Usuario.Clave = txtPassword.Text;
                }

                if (UsuarioNegocio.CheckMail(txtEmail.Text))
                {
                    lblError.Text = "El mail ingresado ya se encuentra registrado.";

                }
                else
                {
                    UsuarioNegocio.Registrar(cliente);
                    Usuario usuario = new Usuario();

                    usuario.NombreUsuario = cliente.Email;
                    usuario.Clave = cliente.Usuario.Clave;
                    if (UsuarioNegocio.Login(usuario))
                    {
                        Session.Add("usuario", usuario);
                        Response.Redirect("~/Default.aspx", false);

                    }




                }




            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("~/Error404.aspx", false);
            }


        }
    }
}