using EcommerceDominio.Usuarios;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Reemplazá esto con tu método real que trae los datos
                // NegocioCliente negocio = new NegocioCliente();
                // dgvClientes.DataSource = negocio.Listar();
                // dgvClientes.DataBind();
            }

            if (Session["usuario"] != null)
            {
                Response.Redirect("~/Cuenta/Perfil.aspx", false);
            }
        }

        protected void btnLoginAcceder_Click(object sender, EventArgs e)
        {
            //if (txtEmail.Text == "admin@mail.com" && txtPassword.Text == "admin")
            //{
            //    Session["AdminLogueado"] = true;
            //    Response.Redirect("~/Admin/DefaultAdmin.aspx", false);
            //}

            try
            {
                Usuario usuario = new Usuario();
                usuario.NombreUsuario = txtEmail.Text;
                usuario.Clave = txtPassword.Text;

                if (UsuarioNegocio.Login(usuario))
                {
                    int id = usuario.Id;
                    int idRol = usuario.Rol.Id;
                    string rol = usuario.Rol.NombreRol;
                    Session.Add("usuario", usuario);
                    if (usuario.Rol.Id == 1)
                    {
                        Response.Redirect("~/Admin/DefaultAdmin.aspx", false);
                    }
                    else
                    {
                        Response.Redirect("~/Default.aspx", false);
                    }

                }
                else
                {
                    lblError.Text = "Credenciales incorrectas. Verifique y vuelva a intentar.";

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