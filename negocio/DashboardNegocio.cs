using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class DashboardNegocio
    {
        // ── KPIs Generales ───────────────────────────────────────────────────────

        /// <summary>
        /// Retorna los KPIs principales: ingresos, cantidad de pedidos, clientes y productos activos.
        /// Admite filtro por rango de fechas y opcionalmente por marca o categoría.
        /// </summary>
        public static DashboardKPI ObtenerKPIs(DateTime desde, DateTime hasta, string tipoCriterio = "", int idCriterio = 0)
        {
            AccesoDatos datos = new AccesoDatos();
            DashboardKPI kpi = new DashboardKPI();

            try
            {
                // Ingresos y cantidad de pedidos (con filtro de fecha y opcionalmente de producto)
                string whereCriterio = "";
                if (tipoCriterio == "Marca")
                    whereCriterio = " AND EXISTS (SELECT 1 FROM ITEM_PEDIDOS IP INNER JOIN PRODUCTOS PR ON IP.IdProducto = PR.Id WHERE IP.IdPedido = P.Id AND PR.IdMarca = @idCriterio)";
                else if (tipoCriterio == "Categoria")
                    whereCriterio = " AND EXISTS (SELECT 1 FROM ITEM_PEDIDOS IP INNER JOIN PRODUCTOS PR ON IP.IdProducto = PR.Id WHERE IP.IdPedido = P.Id AND PR.IdCategoria = @idCriterio)";

                string query = $@"
                    SELECT 
                        ISNULL(SUM(P.Precio), 0) AS Ingresos,
                        COUNT(P.Id) AS CantPedidos
                    FROM PEDIDOS P
                    WHERE P.Fecha >= @desde AND P.Fecha <= @hasta
                    {whereCriterio}";

                datos.setearConsulta(query);
                datos.setearParametros("@desde", desde);
                datos.setearParametros("@hasta", hasta);
                if (!string.IsNullOrEmpty(tipoCriterio))
                    datos.setearParametros("@idCriterio", idCriterio);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    kpi.Ingresos = Convert.ToDecimal(datos.Lector["Ingresos"]);
                    kpi.CantidadPedidos = Convert.ToInt32(datos.Lector["CantPedidos"]);
                }
                datos.cerrarConexion();

                // Clientes totales (no se filtra por fecha/criterio)
                datos.setearConsulta("SELECT COUNT(Id) AS CantClientes FROM CLIENTES");
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    kpi.CantidadClientes = Convert.ToInt32(datos.Lector["CantClientes"]);
                datos.cerrarConexion();

                // Productos activos (no se filtra por fecha/criterio)
                datos.setearConsulta("SELECT COUNT(Id) AS CantProductos FROM PRODUCTOS WHERE Estado = 1");
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    kpi.ProductosActivos = Convert.ToInt32(datos.Lector["CantProductos"]);

                kpi.TicketPromedio = kpi.CantidadPedidos > 0 ? kpi.Ingresos / kpi.CantidadPedidos : 0;

                return kpi;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.cerrarConexion(); }
        }

        // ── Gráfico de Ventas por Mes ─────────────────────────────────────────────

        /// <summary>
        /// Retorna ingresos agrupados por mes para el período indicado (gráfico de líneas).
        /// </summary>
        public static List<VentaMensual> ObtenerVentasPorMes(DateTime desde, DateTime hasta, string tipoCriterio = "", int idCriterio = 0)
        {
            AccesoDatos datos = new AccesoDatos();
            List<VentaMensual> lista = new List<VentaMensual>();

            try
            {
                // Filtro por criterio: si se especifica Marca/Categoria filtramos pedidos que contengan productos de ese criterio
                string whereCriterio = "";
                if (tipoCriterio == "Marca")
                    whereCriterio = " AND EXISTS (SELECT 1 FROM ITEM_PEDIDOS IP INNER JOIN PRODUCTOS PR ON IP.IdProducto = PR.Id WHERE IP.IdPedido = P.Id AND PR.IdMarca = @idCriterio)";
                else if (tipoCriterio == "Categoria")
                    whereCriterio = " AND EXISTS (SELECT 1 FROM ITEM_PEDIDOS IP INNER JOIN PRODUCTOS PR ON IP.IdProducto = PR.Id WHERE IP.IdPedido = P.Id AND PR.IdCategoria = @idCriterio)";

                string query = $@"
                    SELECT 
                        YEAR(P.Fecha) AS Anio,
                        MONTH(P.Fecha) AS Mes,
                        SUM(P.Precio) AS Total,
                        COUNT(P.Id) AS CantPedidos
                    FROM PEDIDOS P
                    WHERE P.Fecha >= @desde AND P.Fecha <= @hasta
                    {whereCriterio}
                    GROUP BY YEAR(P.Fecha), MONTH(P.Fecha)
                    ORDER BY Anio, Mes";

                datos.setearConsulta(query);
                datos.setearParametros("@desde", desde);
                datos.setearParametros("@hasta", hasta);
                if (!string.IsNullOrEmpty(tipoCriterio)) datos.setearParametros("@idCriterio", idCriterio);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(new VentaMensual
                    {
                        Anio = Convert.ToInt32(datos.Lector["Anio"]),
                        Mes = Convert.ToInt32(datos.Lector["Mes"]),
                        Total = Convert.ToDecimal(datos.Lector["Total"]),
                        CantidadPedidos = Convert.ToInt32(datos.Lector["CantPedidos"])
                    });
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.cerrarConexion(); }
        }

        // ── Gráfico de Ventas por Categoría ──────────────────────────────────────

        /// <summary>
        /// Retorna ingresos agrupados por categoría (gráfico de Doughnut).
        /// </summary>
        public static List<VentaPorCriterio> ObtenerVentasPorCategoria(DateTime desde, DateTime hasta, string tipoCriterio = "", int idCriterio = 0)
        {
            AccesoDatos datos = new AccesoDatos();
            List<VentaPorCriterio> lista = new List<VentaPorCriterio>();

            try
            {
                string whereCriterio = "";
                if (tipoCriterio == "Marca")
                    whereCriterio = " AND P.IdMarca = @idCriterio";
                else if (tipoCriterio == "Categoria")
                    whereCriterio = " AND P.IdCategoria = @idCriterio";

                string query = $@"
                    SELECT 
                        C.Nombre AS Criterio,
                        SUM(IP.Precio) AS Total,
                        COUNT(DISTINCT IP.IdPedido) AS CantPedidos
                    FROM ITEM_PEDIDOS IP
                    INNER JOIN PRODUCTOS P ON IP.IdProducto = P.Id
                    INNER JOIN CATEGORIAS C ON P.IdCategoria = C.Id
                    INNER JOIN PEDIDOS PD ON IP.IdPedido = PD.Id
                    WHERE PD.Fecha >= @desde AND PD.Fecha <= @hasta
                    {whereCriterio}
                    GROUP BY C.Nombre
                    ORDER BY Total DESC";

                datos.setearConsulta(query);
                datos.setearParametros("@desde", desde);
                datos.setearParametros("@hasta", hasta);
                if (!string.IsNullOrEmpty(tipoCriterio)) datos.setearParametros("@idCriterio", idCriterio);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(new VentaPorCriterio
                    {
                        Nombre = (string)datos.Lector["Criterio"],
                        Total = Convert.ToDecimal(datos.Lector["Total"]),
                        CantidadPedidos = Convert.ToInt32(datos.Lector["CantPedidos"])
                    });
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.cerrarConexion(); }
        }

        // ── Top Productos Más Vendidos ────────────────────────────────────────────

        /// <summary>
        /// Retorna el top N de productos más vendidos por unidades vendidas.
        /// </summary>
        public static List<ProductoVenta> ObtenerTopProductos(DateTime desde, DateTime hasta, int top = 5, string tipoCriterio = "", int idCriterio = 0)
        {
            AccesoDatos datos = new AccesoDatos();
            List<ProductoVenta> lista = new List<ProductoVenta>();

            try
            {
                string whereCriterio = "";
                if (tipoCriterio == "Marca") whereCriterio = " AND P.IdMarca = @idCriterio";
                else if (tipoCriterio == "Categoria") whereCriterio = " AND P.IdCategoria = @idCriterio";

                string query = $@"
                    SELECT TOP {top}
                        P.Nombre,
                        P.Sku,
                        SUM(IP.Cantidad) AS UnidadesVendidas,
                        SUM(IP.Precio) AS IngresoTotal
                    FROM ITEM_PEDIDOS IP
                    INNER JOIN PRODUCTOS P ON IP.IdProducto = P.Id
                    INNER JOIN PEDIDOS PD ON IP.IdPedido = PD.Id
                    WHERE PD.Fecha >= @desde AND PD.Fecha <= @hasta
                    {whereCriterio}
                    GROUP BY P.Id, P.Nombre, P.Sku
                    ORDER BY UnidadesVendidas DESC";

                datos.setearConsulta(query);
                datos.setearParametros("@desde", desde);
                datos.setearParametros("@hasta", hasta);
                if (!string.IsNullOrEmpty(tipoCriterio)) datos.setearParametros("@idCriterio", idCriterio);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(new ProductoVenta
                    {
                        Nombre = (string)datos.Lector["Nombre"],
                        Sku = (string)datos.Lector["Sku"],
                        UnidadesVendidas = Convert.ToInt32(datos.Lector["UnidadesVendidas"]),
                        IngresoTotal = Convert.ToDecimal(datos.Lector["IngresoTotal"])
                    });
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.cerrarConexion(); }
        }

        // ── Productos Sin Ventas (Stock Estancado) ────────────────────────────────

        /// <summary>
        /// Retorna productos activos que no tuvieron ninguna venta en el período.
        /// </summary>
        public static List<ProductoVenta> ObtenerProductosSinVentas(DateTime desde, DateTime hasta, string tipoCriterio = "", int idCriterio = 0)
        {
            AccesoDatos datos = new AccesoDatos();
            List<ProductoVenta> lista = new List<ProductoVenta>();

            try
            {
                string whereCriterio = "";
                if (tipoCriterio == "Marca") whereCriterio = " AND P.IdMarca = @idCriterio";
                else if (tipoCriterio == "Categoria") whereCriterio = " AND P.IdCategoria = @idCriterio";

                string query = $@"
                    SELECT 
                        P.Nombre,
                        P.Sku,
                        ISNULL(P.Stock, 0) AS Stock
                    FROM PRODUCTOS P
                    WHERE P.Estado = 1
                    {whereCriterio}
                    AND P.Id NOT IN (
                        SELECT DISTINCT IP.IdProducto 
                        FROM ITEM_PEDIDOS IP
                        INNER JOIN PEDIDOS PD ON IP.IdPedido = PD.Id
                        WHERE PD.Fecha >= @desde AND PD.Fecha <= @hasta
                    )
                    ORDER BY Stock DESC";

                datos.setearConsulta(query);
                datos.setearParametros("@desde", desde);
                datos.setearParametros("@hasta", hasta);
                if (!string.IsNullOrEmpty(tipoCriterio)) datos.setearParametros("@idCriterio", idCriterio);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(new ProductoVenta
                    {
                        Nombre = (string)datos.Lector["Nombre"],
                        Sku = (string)datos.Lector["Sku"],
                        UnidadesVendidas = 0,
                        Stock = Convert.ToInt32(datos.Lector["Stock"])
                    });
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.cerrarConexion(); }
        }

        // ── Últimos Pedidos ───────────────────────────────────────────────────────

        /// <summary>
        /// Retorna los últimos N pedidos para la tabla de actividad reciente.
        /// </summary>
        public static List<UltimoPedido> ObtenerUltimosPedidos(int cantidad = 10)
        {
            AccesoDatos datos = new AccesoDatos();
            List<UltimoPedido> lista = new List<UltimoPedido>();

            try
            {
                string query = $@"
                    SELECT TOP {cantidad}
                        P.Id,
                        C.Nombre + ' ' + C.Apellido AS NombreCliente,
                        P.Fecha,
                        P.Precio,
                        E.Estado
                    FROM PEDIDOS P
                    INNER JOIN CLIENTES C ON P.IdCliente = C.Id
                    INNER JOIN ESTADOS_DE_PEDIDO E ON P.IdEstado = E.Id
                    ORDER BY P.Fecha DESC";

                datos.setearConsulta(query);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(new UltimoPedido
                    {
                        Id = Convert.ToInt32(datos.Lector["Id"]),
                        NombreCliente = (string)datos.Lector["NombreCliente"],
                        Fecha = (DateTime)datos.Lector["Fecha"],
                        Total = Convert.ToDecimal(datos.Lector["Precio"]),
                        Estado = (string)datos.Lector["Estado"]
                    });
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.cerrarConexion(); }
        }
    }

    // ── DTOs / Modelos para el Dashboard ─────────────────────────────────────────

    public class DashboardKPI
    {
        public decimal Ingresos { get; set; }
        public int CantidadPedidos { get; set; }
        public int CantidadClientes { get; set; }
        public int ProductosActivos { get; set; }
        public decimal TicketPromedio { get; set; }
    }

    public class VentaMensual
    {
        public int Anio { get; set; }
        public int Mes { get; set; }
        public decimal Total { get; set; }
        public int CantidadPedidos { get; set; }
        public string MesNombre => new DateTime(Anio, Mes, 1).ToString("MMM yyyy");
    }

    public class VentaPorCriterio
    {
        public string Nombre { get; set; }
        public decimal Total { get; set; }
        public int CantidadPedidos { get; set; }
    }

    public class ProductoVenta
    {
        public string Nombre { get; set; }
        public string Sku { get; set; }
        public int UnidadesVendidas { get; set; }
        public decimal IngresoTotal { get; set; }
        public int Stock { get; set; }
    }

    public class UltimoPedido
    {
        public int Id { get; set; }
        public string NombreCliente { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
        public string Estado { get; set; }
    }
}
