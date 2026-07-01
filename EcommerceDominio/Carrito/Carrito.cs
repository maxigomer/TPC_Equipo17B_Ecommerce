using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
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
        public List<ItemCarrito> Items { get; set; }

        public Carrito()
        {
            Items = new List<ItemCarrito>();
        }
        //public virtual Usuarios.Cliente Cliente { get; set; }

        //public virtual ICollection<ItemCarrito> Items { get; set; } = new List<ItemCarrito>();

        public int Count()
        {
            int contador = 0;
            foreach(ItemCarrito item in Items)
            {
                contador += item.Cantidad;

            }
            return contador;
        }
        
        public decimal GetTotal()
        {
            decimal total = 0;

            foreach(ItemCarrito item in Items)
            {
                total += (item.Cantidad * item.Precio);
            }
            return total;
        }
    }
}
