using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Parametros
{
    public class EstadoPedido
    {
        public int IdEstadoPedido { get; set; }
        public string Nombre { get; set; } // Pendiente, Pagado, Enviado...
    }
}
