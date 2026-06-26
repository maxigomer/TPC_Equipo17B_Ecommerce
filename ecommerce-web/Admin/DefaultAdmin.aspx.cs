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
    public partial class DefaultAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ColeccionNegocio coleccion = new ColeccionNegocio();
                Session.Add("listadoColecciones", coleccion.listar());
                dgvColeccionesMenu.DataSource = Session["listadoColecciones"];
                dgvColeccionesMenu.DataBind();

            }




        }

        protected void btnActualizarColecciones_Click(object sender, EventArgs e)
        {
            List<Coleccion> colecciones = new List<Coleccion>();
            ColeccionNegocio negocio = new ColeccionNegocio();

            try
            {
                foreach (GridViewRow row in dgvColeccionesMenu.Rows)
                {
                    Coleccion coleccion = new Coleccion();

                    coleccion.Id = (int)dgvColeccionesMenu.DataKeys[row.RowIndex].Value;
                    coleccion.Nombre = ((TextBox)row.FindControl("txtNombre")).Text;
                    coleccion.Criterio = ((DropDownList)row.FindControl("ddlCriterio")).SelectedValue;
                    if (((DropDownList)row.FindControl("ddlFiltro")).SelectedValue != "")
                    {
                        coleccion.IdCriterio = Convert.ToInt32(((DropDownList)row.FindControl("ddlFiltro")).SelectedValue);
                    }
                    else
                    {
                        coleccion.IdCriterio = 0;
                    }
                    coleccion.Estado = ((DropDownList)row.FindControl("ddlEstado")).SelectedValue == "Activo" ? true : false;

                    colecciones.Add(coleccion);
                }


                negocio.Actualizar(colecciones);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("../Error404.aspx", false);
            }

        }

        protected void dgvColeccionesMenu_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DropDownList ddlCriterio = (DropDownList)e.Row.FindControl("ddlCriterio");
                    DropDownList ddlFiltro = (DropDownList)e.Row.FindControl("ddlFiltro");
                    DropDownList ddlEstado = (DropDownList)e.Row.FindControl("ddlEstado");

                    Coleccion coleccion = (Coleccion)e.Row.DataItem;

                    ddlCriterio.Items.Add("");
                    ddlCriterio.Items.Add("Marca");
                    ddlCriterio.Items.Add("Categoria");

                    if (!string.IsNullOrEmpty(coleccion.Criterio))
                    {
                        ddlCriterio.SelectedValue = coleccion.Criterio;
                    }
                    else
                    {
                        ddlCriterio.SelectedIndex = 0;
                    }

                    if (ddlCriterio.SelectedValue == "Marca")
                    {
                        MarcaNegocio marca = new MarcaNegocio();
                        ddlFiltro.DataSource = marca.listar();
                        ddlFiltro.DataValueField = "Id";
                        ddlFiltro.DataTextField = "Nombre";
                        ddlFiltro.DataBind();

                    }
                    else if (ddlCriterio.SelectedValue == "Categoria")
                    {
                        CategoriaNegocio categoria = new CategoriaNegocio();
                        ddlFiltro.DataSource = categoria.listar();
                        ddlFiltro.DataValueField = "Id";
                        ddlFiltro.DataTextField = "Nombre";
                        ddlFiltro.DataBind();

                    }

                    ddlEstado.Items.Add("Activo");
                    ddlEstado.Items.Add("Draft");

                    ddlEstado.SelectedValue = coleccion.Estado ? "Activo" : "Draft";



                }

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("../Error404.aspx", false);

            }

        }

        protected void ddlCriterio_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                DropDownList ddlCriterio = (DropDownList)sender;
                GridViewRow fila = (GridViewRow)ddlCriterio.NamingContainer;
                DropDownList ddlFiltro = (DropDownList)fila.FindControl("ddlFiltro");

                ddlFiltro.Items.Clear();

                if (ddlCriterio.SelectedValue == "Marca")
                {
                    MarcaNegocio marca = new MarcaNegocio();
                    ddlFiltro.DataSource = marca.listar();
                    ddlFiltro.DataValueField = "Id";
                    ddlFiltro.DataTextField = "Nombre";
                    ddlFiltro.DataBind();
                }
                else if (ddlCriterio.SelectedValue == "Categoria")
                {
                    CategoriaNegocio categoria = new CategoriaNegocio();
                    ddlFiltro.DataSource = categoria.listar();
                    ddlFiltro.DataValueField = "Id";
                    ddlFiltro.DataTextField = "Nombre";
                    ddlFiltro.DataBind();

                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("../Error404.aspx", false);
            }

        }

        protected void btnUrlBanner_Click(object sender, EventArgs e)
        {
            imgBanner.ImageUrl = txtUrlBanner.Text;

        }

        protected void btnActualizarBanner_Click(object sender, EventArgs e)
        {
            try
            {
                BannerNegocio.Actualizar(imgBanner.ImageUrl);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }

        }
    }
}