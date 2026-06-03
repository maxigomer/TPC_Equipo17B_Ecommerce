using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Carrito
{
    public class ItemCarrito
    {
        public int IdItemCarrito { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }

        // Relaciones
        public int IdCarrito { get; set; }
        public virtual Carrito Carrito { get; set; }

        public int IdProducto { get; set; }
        public virtual Producto Producto { get; set; }
    }
}
