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
                if (carrito.GetTotal() < 500000)
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

                if (cliente.Telefono != "")
                {
                    txtTelefono.Text = cliente.Telefono;
                }
                if (cliente.DNI != "")
                {
                    txtDni.Text = cliente.DNI;
                }

                if(cliente.Direcciones.Count() > 0)
                {
                    ddlDirecciones.DataSource = cliente.Direcciones;
                    ddlDirecciones.DataValueField = "Id";
                    ddlDirecciones.DataTextField = "DireccionCompleta";
                    ddlDirecciones.DataBind();
                }


            }

        }

        protected void btnComprar_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (!Page.IsValid)
            {
                return;

            }

            try
            {
                Carrito carrito = (Carrito)Session["carrito"];
                Direccion direccion = new Direccion();
                Usuario usuario = (Usuario)Session["usuario"];

                if (rbEnvio.Checked)
                {
                    direccion.Calle = txtCalle.Text;
                    direccion.Numero = int.Parse(txtNumeroCalle.Text);
                    direccion.Localidad = txtLocalidad.Text;
                    direccion.CodigoPostal = txtCodigoPostal.Text;
                    direccion.Observaciones = txtObservaciones.Text;

                }
                else if (rbRetirarLocal.Checked)
                {
                    direccion.Id = -1;
                }

                if (rbTarjeta.Checked)
                {
                    if (CheckoutNegocio.ProcesarCheckout(txtNumeroTarjeta.Text, txtNombreTarjeta.Text, txtVencimientoTarjeta.Text, txtCodigoSeguridadTarjeta.Text, carrito.GetTotal()))
                    {
                        PedidoNegocio.Compra((Carrito)Session["carrito"], UsuarioNegocio.GetCliente(usuario.Id), direccion,1);
                        Session["carrito"] = null;
                        Response.Redirect("~/Cart/CompraExitosa.aspx", false);

                    }

                }
                else if (rbTransferencia.Checked)
                {
                    PedidoNegocio.Compra((Carrito)Session["carrito"], UsuarioNegocio.GetCliente(usuario.Id), direccion,2,txtDniTransferencia.Text);
                    Session["carrito"] = null;
                    Response.Redirect("~/Cart/CompraExitosa.aspx", false);


                }



            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("~/Error404.aspx", false);
            }
        }

        protected void MetodoPago_CheckedChanged(object sender, EventArgs e)
        {
            pnlTarjeta.Visible = rbTarjeta.Checked;
            pnlTransferencia.Visible = rbTransferencia.Checked;

        }

        protected void MetodoEntrega_CheckedChanged(object sender, EventArgs e)
        {
            pnlEnvio.Visible = rbEnvio.Checked;
            pnlRetirarLocal.Visible = rbRetirarLocal.Checked;

        }

        protected void cvMetodoEntrega_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = rbEnvio.Checked || rbRetirarLocal.Checked;

        }
        protected void cvMetodoPago_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = rbTarjeta.Checked || rbTransferencia.Checked;

        }
    }
}
