using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Pedidos
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
