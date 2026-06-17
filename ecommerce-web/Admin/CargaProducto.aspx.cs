using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using EcommerceDominio.Catalogo;
using System.Globalization;
using System.Runtime.InteropServices;

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

                    ddEstado.Items.Add("Activo");
                    ddEstado.Items.Add("Draft");

                    Session["listaUrl"] = null;

                }

                if (!IsPostBack && Request.QueryString["id"] != null)
                {
                    Producto producto = new Producto();
                    ProductoNegocio negocio = new ProductoNegocio();
                    ImagenNegocio imgNegocio = new ImagenNegocio();
                    producto = negocio.listar(int.Parse(Request.QueryString["id"].ToString()));
                    txtNombre.Text = producto.Nombre;
                    txtDescripcion.Text = producto.Descripcion;
                    ddCategoria.SelectedValue = producto.Categoria.Id.ToString();
                    ddMarca.SelectedValue = producto.Marca.Id.ToString();
                    txtStock.Text = producto.Stock.ToString();
                    txtSku.Text = producto.Sku;
                    txtPrecio.Text = producto.Precio.ToString();
                    txtCosto.Text = ((decimal)producto.Costo).ToString(CultureInfo.InvariantCulture);
                    ddEstado.SelectedValue = producto.Estado ? "Activo" : "Draft";
                    btnAgregarProducto.Text = "Modificar";
                    Session["listaUrl"] = imgNegocio.listar(int.Parse(Request.QueryString["id"].ToString()));
                    repImagenes.DataSource = (List<Imagen>)Session["listaUrl"];
                    repImagenes.DataBind();





                }

                if (IsPostBack)
                {


                }

            }
            catch (Exception)
            {

            }

        }


        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                ProductoNegocio negocio = new ProductoNegocio();
                ImagenNegocio imagenNegocio = new ImagenNegocio();

                if(txtSku.Text != "" && negocio.checkSku(txtSku.Text))
                {
                    lblSku.Text = "Ya existe el SKU!";

                    return;

                }
                Page.Validate();


                Producto producto = new Producto();
                producto.Nombre = txtNombre.Text;
                producto.Descripcion = txtDescripcion.Text;
                producto.Categoria = new Categoria();
                if (Request.Form[ddCategoria.UniqueID].StartsWith("NEW|"))
                {

                    string nuevaCategoria = Request.Form[ddCategoria.UniqueID];
                    CategoriaNegocio categoria = new CategoriaNegocio();
                    producto.Categoria.Id = categoria.agregarScalar(nuevaCategoria.Substring(4));

                }
                else
                {
                    producto.Categoria.Id = int.Parse(ddCategoria.SelectedValue);

                }
                producto.Marca = new Marca();
                if (Request.Form[ddMarca.UniqueID].StartsWith("NEW|"))
                {
                    string nuevaMarca = Request.Form[ddMarca.UniqueID];
                    MarcaNegocio marca = new MarcaNegocio();
                    producto.Marca.Id = marca.agregarScalar(nuevaMarca.Substring(4));

                }
                else
                {
                    producto.Marca.Id = int.Parse(ddMarca.SelectedValue);

                }
                producto.Sku = txtSku.Text;
                producto.Stock = int.Parse(txtStock.Text);
                producto.Precio = decimal.Parse(txtPrecio.Text, CultureInfo.InvariantCulture);
                if(txtCosto.Text == "" || txtCosto.Text == null)
                {
                    producto.Costo = null;
                }
                else
                {
                    producto.Costo = decimal.Parse(txtCosto.Text, CultureInfo.InvariantCulture);
                }
                producto.Estado = ddEstado.SelectedValue == "Activo" ? true : false;


                if (Request.QueryString["id"] != null)
                {
                    producto.Id = int.Parse(Request.QueryString["id"].ToString());
                    if (Session["listaUrl"] != null)
                    {
                        foreach(Imagen img in (List<Imagen>)Session["listaUrl"])
                        {
                            if(img.Id == 0)
                            {
                                imagenNegocio.agregarImagen(img.Url, producto.Id);
                                

                            }

                        }

                        //imagenNegocio.agregarImagen((List<Imagen>)Session["listaUrl"], producto.Id);

                    }
                    if (Session["listaImagenesEliminadas"] != null)
                    {
                        foreach(int id in (List<int>)Session["listaImagenesEliminadas"])
                        {
                            imagenNegocio.eliminar(id);

                        }

                    }
                        negocio.modificar(producto);

                }
                else
                {
                    if (Session["listaUrl"] != null)
                    {

                        imagenNegocio.agregarImagen((List<Imagen>)Session["listaUrl"], negocio.agregarScalar(producto));

                    }
                    else
                    {
                        negocio.agregar(producto);

                    }

                }



                Response.Redirect("Productos.aspx", false);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                //Response.Redirect("Productos.aspx", false);
            }
            finally
            {
                CategoriaNegocio categoria = new CategoriaNegocio();
                MarcaNegocio marca = new MarcaNegocio();
                categoria.check();
                marca.check();
            }

            //if (test.StartsWith("NEW|"))
            //{
            //    test = test.Substring(4);
            //}

        }

        protected void btnAgregarUrlImagen_Click(object sender, EventArgs e)
        {
            string url = txtUrlImagen.Text;

            try
            {
                if (txtUrlImagen.Text == "" || txtUrlImagen.Text == null)
                {
                    return;

                }
                if (Session["listaUrl"] == null)
                {
                    //List<string> lista = new List<string>();
                    //lista.Add(url);
                    //Session.Add("listaUrl", lista);

                    List<Imagen> listaImagenes = new List<Imagen>();
                    listaImagenes.Add(new Imagen(url));
                    Session.Add("listaUrl", listaImagenes);
                }
                else
                {
                    //((List<string>)Session["listaUrl"]).Add(url);
                    ((List<Imagen>)Session["listaUrl"]).Add(new Imagen(url));
                }
                repImagenes.DataSource = (List<Imagen>)Session["listaUrl"];
                repImagenes.DataBind();
                txtUrlImagen.Text = null;

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }

        }

        protected void btnEliminarImagen_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            List<Imagen> lista = (List<Imagen>)Session["listaUrl"];
            List<int> idImagenesEliminar = new List<int>();

            if (lista[item.ItemIndex].Id != 0)
            {
                if (Session["listaImagenesEliminadas"] != null)
                {
                    idImagenesEliminar = (List<int>)Session["listaImagenesEliminadas"];
                }
                    idImagenesEliminar.Add(lista[item.ItemIndex].Id);
                    Session.Add("listaImagenesEliminadas", idImagenesEliminar);
            }

            lista.RemoveAt(item.ItemIndex);

            Session["listaUrl"] = lista;

            repImagenes.DataSource = Session["listaUrl"];
            repImagenes.DataBind();

            //RepeaterItem item = 
            //List<Imagen> lista = (List<Imagen>)Session["listaUrl"];

        }

       
        protected void cvSku_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if(args.Value == "")
            {
                args.IsValid = true;
            }

        }
    }
}