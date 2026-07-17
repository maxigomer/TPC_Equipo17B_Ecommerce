using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ecommerce_web.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        // Guarda el máximo de unidades vendidas del top productos para las barras de progreso
        private int _maxUnidades = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Fechas por defecto: últimos 12 meses
                txtDesde.Text = DateTime.Now.AddMonths(-12).ToString("yyyy-MM-dd");
                txtHasta.Text = DateTime.Now.ToString("yyyy-MM-dd");

                CargarFiltroCriterio();
                CargarDashboard();
            }
        }

        // ── Carga el DropDownList de Marcas o Categorías al cambiar el criterio ──

        private void CargarFiltroCriterio()
        {
            ddlFiltroValor.Items.Clear();
            ddlFiltroValor.Items.Add(new ListItem("Todos", "0"));

            if (ddlCriterio.SelectedValue == "Marca")
            {
                MarcaNegocio marcaNeg = new MarcaNegocio();
                foreach (var m in marcaNeg.listar())
                    ddlFiltroValor.Items.Add(new ListItem(m.Nombre, m.Id.ToString()));
            }
            else if (ddlCriterio.SelectedValue == "Categoria")
            {
                CategoriaNegocio catNeg = new CategoriaNegocio();
                foreach (var c in catNeg.listar())
                    ddlFiltroValor.Items.Add(new ListItem(c.Nombre, c.Id.ToString()));
            }
        }

        // ── Recarga todos los datos del dashboard ──────────────────────────────

        private void CargarDashboard()
        {
            DateTime desde = DateTime.Parse(txtDesde.Text);
            DateTime hasta = DateTime.Parse(txtHasta.Text).AddDays(1).AddSeconds(-1); // fin del día

            string tipoCriterio = ddlCriterio.SelectedValue;
            int idCriterio = int.Parse(ddlFiltroValor.SelectedValue);
            if (idCriterio == 0) tipoCriterio = ""; // "Todos" => sin filtro de criterio

            // ── KPIs ──
            var kpi = DashboardNegocio.ObtenerKPIs(desde, hasta, tipoCriterio, idCriterio);
            litIngresos.Text    = string.Format("{0:N0}", kpi.Ingresos);
            litCantPedidos.Text = kpi.CantidadPedidos.ToString("N0");
            litTicket.Text      = string.Format("{0:N0}", kpi.TicketPromedio);
            litClientes.Text    = kpi.CantidadClientes.ToString("N0");
            litProductos.Text   = kpi.ProductosActivos.ToString("N0");

            // ── Gráfico de líneas: ventas por mes ──
            var ventasMes = DashboardNegocio.ObtenerVentasPorMes(desde, hasta);
            hfVentasMeses.Value   = string.Join("|", ventasMes.Select(v => v.MesNombre));
            hfVentasTotales.Value = string.Join("|", ventasMes.Select(v => ((long)v.Total).ToString()));

            // ── Gráfico doughnut: ventas por categoría ──
            var ventasCat = DashboardNegocio.ObtenerVentasPorCategoria(desde, hasta);
            hfCategoriaNombres.Value = string.Join("|", ventasCat.Select(c => c.Nombre));
            hfCategoriaTotales.Value = string.Join("|", ventasCat.Select(c => ((long)c.Total).ToString()));

            // ── Top productos ──
            var topProductos = DashboardNegocio.ObtenerTopProductos(desde, hasta, 5);
            _maxUnidades = topProductos.Any() ? topProductos.Max(p => p.UnidadesVendidas) : 1;
            rpTopProductos.DataSource = topProductos;
            rpTopProductos.DataBind();

            // ── Productos sin ventas ──
            var sinVentas = DashboardNegocio.ObtenerProductosSinVentas(desde, hasta);
            if (sinVentas.Any())
            {
                rpSinVentas.DataSource = sinVentas;
                rpSinVentas.DataBind();
                lblSinVentasVacio.Visible = false;
            }
            else
            {
                rpSinVentas.DataSource = null;
                rpSinVentas.DataBind();
                lblSinVentasVacio.Visible = true;
            }

            // ── Últimos pedidos ──
            var ultimosPedidos = DashboardNegocio.ObtenerUltimosPedidos(10);
            gvUltimosPedidos.DataSource = ultimosPedidos;
            gvUltimosPedidos.DataBind();

            // Registrar script para re-renderizar gráficos tras UpdatePanel
            ScriptManager.RegisterStartupScript(this, GetType(), "renderCharts", "renderCharts();", true);
        }

        // ── Evento del botón de filtros ────────────────────────────────────────

        protected void btnAplicar_Click(object sender, EventArgs e)
        {
            CargarFiltroCriterio();
            CargarDashboard();
        }

        // ── Helpers para la vista ──────────────────────────────────────────────

        /// <summary>
        /// Devuelve el ancho de la barra de progreso en % relativo al máximo del top.
        /// </summary>
        public int GetBarWidth(int unidades)
        {
            if (_maxUnidades <= 0) return 0;
            return Math.Max(4, (int)Math.Round((double)unidades / _maxUnidades * 100));
        }

        /// <summary>
        /// Devuelve la clase CSS de color para el badge de estado de pedido.
        /// </summary>
        public string GetBadgeClass(string estado)
        {
            switch (estado?.ToLower())
            {
                case "pendiente": return "badge-estado badge-pendiente";
                case "enviado":   return "badge-estado badge-enviado";
                case "entregado": return "badge-estado badge-entregado";
                case "cancelado": return "badge-estado badge-cancelado";
                default:          return "badge-estado badge-default";
            }
        }
    }
}
