using negocio;
using System;
using System.Threading;
using System.Web;

namespace ecommerce_web
{
    public class Global : HttpApplication
    {
        // ── Timer para actualización automática de estados ──────────────────────
        private static Timer _estadoTimer;

        // Intervalo de ejecución: cada 2 horas
        private static readonly TimeSpan INTERVALO = TimeSpan.FromHours(2);

        // ── Eventos del ciclo de vida de la aplicación ──────────────────────────

        protected void Application_Start(object sender, EventArgs e)
        {
            // Iniciamos el timer al arrancar la app.
            // El primer disparo ocurre al inicio (dueTime = 0) para verificar
            // pedidos que quedaron pendientes si el servidor estuvo caído.
            _estadoTimer = new Timer(
                callback:  _ => EjecutarActualizacionEstados(),
                state:     null,
                dueTime:   TimeSpan.Zero,
                period:    INTERVALO
            );
        }

        protected void Application_End(object sender, EventArgs e)
        {
            // Liberamos el timer al apagar la aplicación para evitar memory leaks
            _estadoTimer?.Dispose();
        }

        // ── Ejecución del proceso automático ────────────────────────────────────

        private static void EjecutarActualizacionEstados()
        {
            try
            {
                PedidoEstadoAutomaticoNegocio.ProcesarActualizaciones();
            }
            catch (Exception)
            {
                // Ignoramos errores para que el Timer nunca se detenga
                // En producción real se loguearía con NLog, Serilog, etc.
            }
        }
    }
}
