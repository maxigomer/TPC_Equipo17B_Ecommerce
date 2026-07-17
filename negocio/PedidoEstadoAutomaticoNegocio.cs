using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    /// <summary>
    /// Lógica de negocio para la actualización automática de estados de pedidos
    /// basada en días hábiles transcurridos desde la fecha del pedido / último cambio de estado.
    /// 
    /// Reglas de negocio:
    ///   - Pendiente → Enviado    : después de 1 día hábil
    ///   - Enviado   → Entregado  : después de 3 días hábiles
    ///   - Pendiente → Cancelado  : si pasaron 7 días corridos y el método de pago
    ///                              fue Transferencia (idMetodoPago == 2)
    /// </summary>
    public static class PedidoEstadoAutomaticoNegocio
    {
        // ── IDs de estado (deben coincidir con la tabla ESTADOS_DE_PEDIDO) ──────
        private const int ESTADO_PENDIENTE  = 1;
        private const int ESTADO_ENVIADO    = 2;
        private const int ESTADO_ENTREGADO  = 3;
        private const int ESTADO_CANCELADO  = 4;

        // ── ID de método de pago por Transferencia ──────────────────────────────
        private const int METODO_TRANSFERENCIA = 2;

        // ── Días hábiles requeridos para avanzar de estado ──────────────────────
        private const int DIAS_HABILES_PENDIENTE_A_ENVIADO  = 1;
        private const int DIAS_HABILES_ENVIADO_A_ENTREGADO  = 3;
        private const int DIAS_CORRIDOS_CANCELACION         = 7;

        // ── Feriados nacionales fijos argentinos (mes, día) ─────────────────────
        private static readonly HashSet<(int mes, int dia)> FeriadosFijos = new HashSet<(int, int)>
        {
            (1,  1),   // Año Nuevo
            (3, 24),   // Día de la Memoria
            (4,  2),   // Malvinas
            (5,  1),   // Día del Trabajador
            (5, 25),   // Revolución de Mayo
            (6, 17),   // Güemes
            (6, 20),   // Belgrano
            (7,  9),   // Independencia
            (8, 17),   // San Martín
            (10,12),   // Diversidad Cultural
            (11,20),   // Soberanía Nacional
            (12, 8),   // Inmaculada Concepción
            (12,25),   // Navidad
        };

        /// <summary>
        /// Punto de entrada principal. Revisa todos los pedidos pendientes y enviados
        /// y avanza los estados que correspondan según las reglas de negocio.
        /// </summary>
        public static void ProcesarActualizaciones()
        {
            try
            {
                var pedidos = ObtenerPedidosParaActualizar();

                foreach (var pedido in pedidos)
                {
                    int nuevoEstado = CalcularNuevoEstado(pedido);

                    if (nuevoEstado != pedido.IdEstado)
                    {
                        PedidoNegocio.ActualizarEstadoPedido(pedido.Id, nuevoEstado);
                        RegistrarObservacionCambioEstado(pedido, nuevoEstado);
                    }
                }
            }
            catch (Exception)
            {
                // Se traga la excepción para que el Timer no se detenga ante un error puntual
            }
        }

        // ── Lógica de cálculo ────────────────────────────────────────────────────

        private static int CalcularNuevoEstado(PedidoResumen pedido)
        {
            DateTime ahora = DateTime.Now;

            if (pedido.IdEstado == ESTADO_PENDIENTE)
            {
                // Cancelación por falta de pago (transferencia no acreditada)
                if (pedido.IdMetodoPago == METODO_TRANSFERENCIA)
                {
                    double diasCorridos = (ahora - pedido.Fecha).TotalDays;
                    if (diasCorridos >= DIAS_CORRIDOS_CANCELACION)
                        return ESTADO_CANCELADO;
                }

                // Pendiente → Enviado
                int diasHabiles = ContarDiasHabiles(pedido.Fecha, ahora);
                if (diasHabiles >= DIAS_HABILES_PENDIENTE_A_ENVIADO)
                    return ESTADO_ENVIADO;
            }
            else if (pedido.IdEstado == ESTADO_ENVIADO)
            {
                // Enviado → Entregado (calculamos desde la fecha del pedido)
                int diasHabiles = ContarDiasHabiles(pedido.Fecha, ahora);
                // Descontamos los días que ya tardaba en enviarse
                int diasNetos = diasHabiles - DIAS_HABILES_PENDIENTE_A_ENVIADO;
                if (diasNetos >= DIAS_HABILES_ENVIADO_A_ENTREGADO)
                    return ESTADO_ENTREGADO;
            }

            return pedido.IdEstado; // Sin cambios
        }

        // ── Calcula días hábiles entre dos fechas ─────────────────────────────────

        private static int ContarDiasHabiles(DateTime desde, DateTime hasta)
        {
            int diasHabiles = 0;
            DateTime cursor = desde.Date.AddDays(1); // Empezamos desde el día siguiente

            while (cursor <= hasta.Date)
            {
                if (EsDiaHabil(cursor))
                    diasHabiles++;
                cursor = cursor.AddDays(1);
            }

            return diasHabiles;
        }

        private static bool EsDiaHabil(DateTime fecha)
        {
            // No es hábil si es sábado o domingo
            if (fecha.DayOfWeek == DayOfWeek.Saturday || fecha.DayOfWeek == DayOfWeek.Sunday)
                return false;

            // No es hábil si es feriado fijo
            if (FeriadosFijos.Contains((fecha.Month, fecha.Day)))
                return false;

            return true;
        }

        // ── Consulta a la BD ──────────────────────────────────────────────────────

        private static List<PedidoResumen> ObtenerPedidosParaActualizar()
        {
            AccesoDatos datos = new AccesoDatos();
            List<PedidoResumen> lista = new List<PedidoResumen>();

            try
            {
                // Traemos solo Pendientes y Enviados — los demás son estados finales
                string query = @"
                    SELECT 
                        P.Id, 
                        P.IdEstado, 
                        P.Fecha, 
                        P.IdMetodoDePago
                    FROM PEDIDOS P
                    WHERE P.IdEstado IN (1, 2)";

                datos.setearConsulta(query);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    var p = new PedidoResumen
                    {
                        Id           = Convert.ToInt32(datos.Lector["Id"]),
                        IdEstado     = Convert.ToInt32(datos.Lector["IdEstado"]),
                        Fecha        = Convert.ToDateTime(datos.Lector["Fecha"]),
                        IdMetodoPago = Convert.ToInt32(datos.Lector["IdMetodoDePago"]),
                    };

                    lista.Add(p);
                }

                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.cerrarConexion(); }
        }

        // ── Registra en observaciones el cambio automático ────────────────────────

        private static void RegistrarObservacionCambioEstado(PedidoResumen pedido, int nuevoEstado)
        {
            try
            {
                string[] nombresEstado = { "", "Pendiente", "Enviado", "Entregado", "Cancelado" };
                string estadoAnterior = pedido.IdEstado <= 4 ? nombresEstado[pedido.IdEstado] : "Desconocido";
                string estadoNuevo    = nuevoEstado    <= 4 ? nombresEstado[nuevoEstado]    : "Desconocido";

                var obs = new EcommerceDominio.Pedidos.ObservacionPedido
                {
                    IdPedido   = pedido.Id,
                    Observacion = $"SISTEMA: Estado actualizado automáticamente de '{estadoAnterior}' a '{estadoNuevo}' el {DateTime.Now:dd/MM/yyyy HH:mm}."
                };

                PedidoNegocio.AgregarObservacion(obs);
            }
            catch (Exception) { /* No crítico */ }
        }

        // ── DTO interno ───────────────────────────────────────────────────────────

        private class PedidoResumen
        {
            public int      Id           { get; set; }
            public int      IdEstado     { get; set; }
            public DateTime Fecha        { get; set; }
            public int      IdMetodoPago { get; set; }
        }
    }
}
