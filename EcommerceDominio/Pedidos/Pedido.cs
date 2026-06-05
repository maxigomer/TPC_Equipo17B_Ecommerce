using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Pedidos
{
    public class Pedido
    {
        public int Id { get; set; }
        public int IdCliente { get; set; }
        public int IdMetodoDePago { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Precio { get; set; } // TOTAL
        public int IdFormaEntrega { get; set; }
        public int IdEstado { get; set; }

        public int? IdDireccion { get; set; } // 'int?' --> (nullable) porque si retira en el local, no requiere dirección

        // Propiedades de navegación (Relaciones)
        public virtual Usuarios.Cliente Cliente { get; set; }
        public virtual Parametros.MetodoPago MetodoPago { get; set; }
        public virtual Parametros.FormaEntrega FormaEntrega { get; set; }
        public virtual Parametros.EstadoPedido EstadoPedido { get; set; }

        public virtual Usuarios.Direccion Direccion { get; set; }

        public virtual ICollection<ItemPedido> Items { get; set; } = new List<ItemPedido>();
        public virtual ICollection<ObservacionPedido> Observaciones { get; set; } = new List<ObservacionPedido>();
    }
}
