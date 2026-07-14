using EcommerceDominio.Carrito;
using EcommerceDominio.Usuarios;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web.Cart
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }

        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (Session["carrito"] != null)
                {

                    Carrito carrito = (Carrito)Session["carrito"];
                    if (carrito.Items.Count < 1)
                    {
                        pnlCarrito.Visible = false;
                        pnlCarritoVacio.Visible = true;

                    }
                    else
                    {
                        rpCart.DataSource = carrito.Items;
                        rpCart.DataBind();
                        pnlCarrito.Visible = true;
                        pnlCarritoVacio.Visible = false;
                        lblSubtotal.Text = "$" + (carrito.GetTotal()).ToString();

                    }

                }
                else
                {
                    pnlCarrito.Visible = false;
                    pnlCarritoVacio.Visible = true;
                }

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("~/Error404.aspx", false);

            }

        }

        protected void btnSumarCantidad_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Carrito carrito = (Carrito)Session["carrito"];

            carrito.Items[item.ItemIndex].Cantidad++;

        }

        protected void btnRestarCantidad_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Carrito carrito = (Carrito)Session["carrito"];

            if (carrito.Items[item.ItemIndex].Cantidad > 1)
                carrito.Items[item.ItemIndex].Cantidad--;

        }

        protected void btnEliminarItem_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            Carrito carrito = (Carrito)Session["carrito"];

            try
            {
                carrito.Items.RemoveAt(item.ItemIndex);
            }
            catch
            {

            }

        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                Response.Redirect("~/Cart/Checkout.aspx", false);
            }
            else
            {
                MostrarModalLogin();
                lblError.Text = "";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
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

                    Response.Redirect("~/Cart/Checkout.aspx", false);

                }
                else
                {
                    MostrarModalLogin();
                    lblError.Text = "Credenciales incorrectas. Verifique y vuelva a intentar.";

                }

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("~/Error404.aspx", false);

            }

        }

        private void MostrarModalLogin()
        {
            ClientScript.RegisterClientScriptBlock(GetType(), "MostrarModal", $@"window.addEventListener('load', function () {{
                    var modal = new bootstrap.Modal(document.getElementById('{modalLogin.ClientID}')); modal.show(); }});", true);

        }
    }
}