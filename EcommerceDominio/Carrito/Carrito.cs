using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Carrito
{
    public class Carrito
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Precio { get; set; }

        public int IdCliente { get; set; }
        public virtual Usuarios.Cliente Cliente { get; set; }

        public virtual ICollection<ItemCarrito> Items { get; set; } = new List<ItemCarrito>();
    }
}
