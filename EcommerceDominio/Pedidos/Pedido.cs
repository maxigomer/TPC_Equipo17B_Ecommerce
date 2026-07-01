using EcommerceDominio.Usuarios;
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
        public Cliente Cliente { get; set; }
        public Direccion Direccion { get; set; }
        public List<ObservacionPedido> Observaciones { get; set; }
        public int IdDireccion {  get; set; }
        public int IdMetodoDePago { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Precio { get; set; } // TOTAL
        public int IdFormaEntrega { get; set; }
        public int IdEstado { get; set; }
        public string Estado {  get; set; }

        public List<ItemPedido> Items { get; set; }

        public Pedido()
        {
            Cliente = new Cliente();
            Direccion = new Direccion();
            Items = new List<ItemPedido>();
            Observaciones = new List<ObservacionPedido>();
        }

    }
}
