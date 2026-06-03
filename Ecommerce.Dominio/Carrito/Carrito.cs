using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Carrito
{
    public class Carrito
    {
        public int IdCarrito { get; set; }
        public DateTime FechaCreacion { get; set; }

        // Relación: Pertenece a un Cliente
        public int IdCliente { get; set; }
        public virtual Cliente Cliente { get; set; }

        public virtual ICollection<ItemCarrito> Items { get; set; } = new List<ItemCarrito>();
    }
}
