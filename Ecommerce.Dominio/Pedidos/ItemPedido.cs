using Ecommerce.Dominio.Catalogo;
using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Pedidos
{
    public class ItemPedido
    {
        public int Id { get; set; }
        public int IdPedido { get; set; }
        public int IdProducto { get; set; }
        public int Cantidad { get; set; }
        public decimal Precio { get; set; }

        public virtual Pedido Pedido { get; set; }
        public virtual Catalogo.Producto Producto { get; set; }
    }
}
