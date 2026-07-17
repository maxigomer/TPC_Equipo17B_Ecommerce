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

                if (!IsPostBack)
                {
                    if (cliente.Direcciones.Count() > 0)
                    {
                        ddlDirecciones.DataSource = cliente.Direcciones;
                        ddlDirecciones.DataValueField = "Id";
                        ddlDirecciones.DataTextField = "DireccionCompleta";
                        ddlDirecciones.DataBind();

                    }
                    
                    ddlDirecciones.Items.Insert(0, new ListItem("Nueva direccion", "0"));

                    MetodoPagoNegocio metodoNegocio = new MetodoPagoNegocio();
                    rblMetodosPago.DataSource = metodoNegocio.Listar().Where(m => m.Estado == true).ToList();
                    rblMetodosPago.DataBind();

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
                    direccion.Id = int.Parse(ddlDirecciones.SelectedValue);
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

                if (!string.IsNullOrEmpty(rblMetodosPago.SelectedValue))
                {
                    int idMetodo = int.Parse(rblMetodosPago.SelectedValue);

                    if (idMetodo == 1) // Tarjeta
                    {
                        if (CheckoutNegocio.ProcesarCheckout(txtNumeroTarjeta.Text, txtNombreTarjeta.Text, txtVencimientoTarjeta.Text, txtCodigoSeguridadTarjeta.Text, carrito.GetTotal()))
                        {
                            PedidoNegocio.Compra((Carrito)Session["carrito"], UsuarioNegocio.GetCliente(usuario.Id), direccion, idMetodo);
                            
                            try
                            {
                                EmailNegocio emailService = new EmailNegocio();
                                string asunto = "¡Confirmación de Compra!";
                                string cuerpo = $"Hola {txtNombre.Text},<br><br>Hemos recibido tu pedido correctamente pagado con tarjeta. El total fue de ${carrito.GetTotal()}.<br><br>¡Gracias por tu compra!";
                                emailService.ArmarCorreo(txtEmail.Text, asunto, cuerpo);
                                emailService.EnviarEmail();
                            }
                            catch (Exception) { }

                            Session["carrito"] = null;
                            Response.Redirect("~/Cart/CompraExitosa.aspx", false);
                        }
                    }
                    else if (idMetodo == 2) // Transferencia
                    {
                        PedidoNegocio.Compra((Carrito)Session["carrito"], UsuarioNegocio.GetCliente(usuario.Id), direccion, idMetodo, txtDniTransferencia.Text);

                        try
                        {
                            EmailNegocio emailService = new EmailNegocio();
                            string asunto = "¡Confirmación de Compra (Pendiente de Transferencia)!";
                            string cuerpo = $"Hola {txtNombre.Text},<br><br>Hemos recibido tu pedido. El total a transferir es de ${carrito.GetTotal()}.<br>Recuerda enviar el comprobante de transferencia con tu DNI ({txtDniTransferencia.Text}) para que procesemos tu envío.<br><br>¡Gracias por tu compra!";
                            emailService.ArmarCorreo(txtEmail.Text, asunto, cuerpo);
                            emailService.EnviarEmail();
                        }
                        catch (Exception) { }

                        Session["MetodoPago"] = "Transferencia";

                        Session["carrito"] = null;
                        Response.Redirect("~/Cart/CompraExitosa.aspx", false);
                    }
               
                    else // Otros metodos
                    {
                        PedidoNegocio.Compra((Carrito)Session["carrito"], UsuarioNegocio.GetCliente(usuario.Id), direccion, idMetodo);
                        
                        try
                        {
                            EmailNegocio emailService = new EmailNegocio();
                            string asunto = "¡Confirmación de Compra!";
                            string cuerpo = $"Hola {txtNombre.Text},<br><br>Hemos recibido tu pedido por un total de ${carrito.GetTotal()}.<br><br>¡Gracias por tu compra!";
                            emailService.ArmarCorreo(txtEmail.Text, asunto, cuerpo);
                            emailService.EnviarEmail();
                        }
                        catch (Exception) { }

                        Session["carrito"] = null;
                        Response.Redirect("~/Cart/CompraExitosa.aspx", false);
                    }
                }            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("~/Error404.aspx", false);
            }
        }

        protected void MetodoPago_CheckedChanged(object sender, EventArgs e)
        {
            pnlTarjeta.Visible = rblMetodosPago.SelectedValue == "1";
            pnlTransferencia.Visible = rblMetodosPago.SelectedValue == "2";
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
            args.IsValid = !string.IsNullOrEmpty(rblMetodosPago.SelectedValue);

        }

        protected void ddlDirecciones_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idDireccion = int.Parse(ddlDirecciones.SelectedValue);

            if(idDireccion == 0)
            {
                txtCalle.Enabled = true;
                txtCodigoPostal.Enabled = true;
                txtLocalidad.Enabled = true;
                txtNumeroCalle.Enabled = true;
                txtObservaciones.Enabled = true;

                txtCalle.Text = "";
                txtCodigoPostal.Text = "";
                txtLocalidad.Text = "";
                txtNumeroCalle.Text = "";
                txtObservaciones.Text = "";

            }
            else
            {
                Direccion direccion = DireccionNegocio.Listar(idDireccion);

                txtCalle.Text = direccion.Calle;
                txtCodigoPostal.Text = direccion.CodigoPostal;
                txtLocalidad.Text = direccion.Localidad;
                txtNumeroCalle.Text = direccion.Numero.ToString();
                txtObservaciones.Text = direccion.Observaciones;

                txtCalle.Enabled = false;
                txtCodigoPostal.Enabled = false;
                txtLocalidad.Enabled = false;
                txtNumeroCalle.Enabled = false;
                txtObservaciones.Enabled = false;

            }



        }
    }
}
