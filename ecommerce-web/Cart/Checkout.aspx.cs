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
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Carrito carrito = (Carrito)Session["carrito"];

            if (Session["usuario"] == null || Session["carrito"] == null || carrito.Items.Count() == 0)
            {
                Response.Redirect("~/Default.aspx", false);
            }
            else
            {
                Usuario usuario = (Usuario)Session["usuario"];
                Cliente cliente = UsuarioNegocio.GetCliente(usuario.Id);
                rpResumenCarrito.DataSource = carrito.Items;
                rpResumenCarrito.DataBind();
                lblSubtotal.Text = "$" + carrito.GetTotal().ToString();
                if(carrito.GetTotal() < 500000)
                {
                    lblEnvio.Text = "$" + 100000;
                }
                else
                {
                    lblEnvio.Text = "Gratis";
                }

                lblTotal.Text = lblEnvio.Text == "Gratis" ? lblSubtotal.Text : "$" + (carrito.GetTotal() + 100000).ToString();
                txtNombre.Text = cliente.Nombre;
                txtApellido.Text = cliente.Apellido;
                txtEmail.Text = cliente.Email;
                
                if(cliente.Telefono != "")
                {
                    txtTelefono.Text = cliente.Telefono;
                }
                if(cliente.DNI != "")
                {
                    txtDni.Text = cliente.DNI;
                }
                
                
            }

        }
    }
}