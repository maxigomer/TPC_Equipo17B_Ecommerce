using Ecommerce.Dominio.Parametros;
using Ecommerce.Dominio.Usuarios;
using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Pedidos
{
    public class Pedido
    {
        public int IdPedido { get; set; }
        public DateTime FechaCreacion { get; set; }
        public decimal Total { get; set; }

        // Claves Foráneas (Relaciones)
        public int IdCliente { get; set; }
        public virtual Cliente Cliente { get; set; }

        public int IdFormaPago { get; set; }
        public virtual FormaPago FormaPago { get; set; }

        public int IdFormaEntrega { get; set; }
        public virtual FormaEntrega FormaEntrega { get; set; }

        public int IdEstadoPedido { get; set; }
        public virtual EstadoPedido EstadoPedido { get; set; }

        public int? IdDireccion { get; set; } // Nullable (int?) porque si retira en sucursal, no hay dirección
        public virtual Direccion Direccion { get; set; }

        // Colecciones hijas
        public virtual ICollection<DetallePedido> Detalles { get; set; } = new List<DetallePedido>();
        public virtual ICollection<ObservacionPedido> Observaciones { get; set; } = new List<ObservacionPedido>();
    }
