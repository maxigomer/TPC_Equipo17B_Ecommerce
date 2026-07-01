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
        public string Imagen { get; set; }
        public string Nombre { get; set; }
        public string Sku { get; set; }
        public int Cantidad { get; set; }
        public decimal Precio { get; set; }

    }
}
