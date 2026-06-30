using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Carrito
{
    public class ItemCarrito
    {
        public int Id { get; set; }
        public int IdCarrito { get; set; }
        public int IdProducto { get; set; }

        public int Cantidad { get; set; }
        public decimal Precio { get; set; }

        //public virtual Carrito Carrito { get; set; }
        //public virtual Catalogo.Producto Producto { get; set; }
    }
}
