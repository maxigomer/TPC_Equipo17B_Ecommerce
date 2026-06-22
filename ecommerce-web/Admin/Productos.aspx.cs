using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web
{
    public partial class Productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductoNegocio negocio = new ProductoNegocio();
                Session.Add("listaProductos", negocio.listar());
                dgvProductos.DataSource = Session["listaProductos"];
                dgvProductos.DataBind();



                //ImagenNegocio imagen = new ImagenNegocio();
                //Session.Add("listaImagenes", imagen.listar());
                //dgvTest.DataSource = Session["listaImagenes"];
                //dgvTest.DataBind();


            }


        }
        protected void btnCargaProducto_Click(object sender, EventArgs e)
        {

            Response.Redirect("CargaProducto.aspx", false);
        }

        protected void dgvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {

            //string id = dgvProductos.SelectedDataKey.Value.ToString();
            //Response.Redirect("CargaProducto.aspx?=" + id, false);
        }

        protected void chkSeleccionado_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            GridViewRow fila = (GridViewRow)chk.NamingContainer;

            int id = (int)dgvProductos.DataKeys[fila.RowIndex].Value;

            List<int> lista = new List<int>();

            if (Session["idChecked"] != null)
            {
                lista = (List<int>)Session["idChecked"];
            }

            if (chk.Checked)
            {
                if (!lista.Contains(id))
                {
                    lista.Add(id);
                }
            }
            else
            {
                lista.Remove(id);
            }

            Session.Add("idChecked", lista);





        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            List<int> lista = new List<int>();
            ProductoNegocio pnegocio = new ProductoNegocio();
            if (Session["idChecked"] != null)
            {
                lista = (List<int>)Session["idChecked"];

                foreach(int id in lista)
                {
                    pnegocio.eliminar(id);

                }
                ProductoNegocio negocio = new ProductoNegocio();
                Session["idChecked"] = null;
                Session.Add("listaProductos", negocio.listar());
                dgvProductos.DataSource = Session["listaProductos"];
                dgvProductos.DataBind();
            }

        }

        protected void btnFiltrar_Click(object sender, EventArgs e) 
        {
            
        }
    }
}