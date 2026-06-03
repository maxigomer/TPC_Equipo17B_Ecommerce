using Ecommerce.Dominio.Catalogo;
using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Pedidos
{
    public class DetallePedido
    {
        public int IdDetallePedido { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal Subtotal { get; set; }

        public int IdPedido { get; set; }
        public virtual Pedido Pedido { get; set; }

        public int IdProducto { get; set; }
        public virtual Producto Producto { get; set; }
    }
}
