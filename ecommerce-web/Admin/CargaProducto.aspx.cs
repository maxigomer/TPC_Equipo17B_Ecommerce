using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using EcommerceDominio.Catalogo;

namespace ecommerce_web
{
    public partial class CargaProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (!IsPostBack)
                {
                    CategoriaNegocio categoria = new CategoriaNegocio();
                    MarcaNegocio marca = new MarcaNegocio();

                    ddCategoria.DataSource = categoria.listar();
                    ddCategoria.DataValueField = "Id";
                    ddCategoria.DataTextField = "Nombre";
                    ddCategoria.DataBind();

                    ddCategoria.Items.Insert(0, "");

                    ddMarca.DataSource = marca.listar();
                    ddMarca.DataValueField = "Id";
                    ddMarca.DataTextField = "Nombre";
                    ddMarca.DataBind();

                    ddMarca.Items.Insert(0, "");

                }

                if (IsPostBack)
                {


                }

            }
            catch (Exception ex)
            {

            }

        }

        protected void btnAgregarCategoria_Click(object sender, EventArgs e)
        {

        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                ProductoNegocio negocio = new ProductoNegocio();
                ImagenNegocio imagenNegocio = new ImagenNegocio();

                Producto producto = new Producto();
                producto.Nombre = txtNombre.Text;
                producto.Descripcion = txtDescripcion.Text;
                producto.Categoria = new Categoria();
                producto.Categoria.Id = int.Parse(ddCategoria.SelectedValue);
                producto.Marca = new Marca();
                producto.Marca.Id = int.Parse(ddMarca.SelectedValue);
                producto.Sku = txtSku.Text;
                producto.Stock = int.Parse(txtStock.Text);
                producto.Precio = int.Parse(txtPrecio.Text);
                producto.Costo = int.Parse(txtCosto.Text);
                producto.Estado = true;


                if (Session["listaUrl"] != null)
                {

                    imagenNegocio.agregarImagen((List<string>)Session["listaUrl"], negocio.agregarScalar(producto));

                }
                else
                {
                    negocio.agregar(producto);

                }




            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                //Response.Redirect("Productos.aspx", false);
            }
            string test = Request.Form[ddCategoria.UniqueID];

            if (test.StartsWith("NEW|"))
            {
                test = test.Substring(4);
            }

        }

        protected void btnAgregarUrlImagen_Click(object sender, EventArgs e)
        {
            string url = txtUrlImagen.Text;

            try
            {
                if (Session["listaUrl"] == null)
                {
                    List<string> lista = new List<string>();
                    lista.Add(url);
                    Session.Add("listaUrl", lista);
                }
                else
                {
                    ((List<string>)Session["listaUrl"]).Add(url);
                }

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }

        }
    }
}