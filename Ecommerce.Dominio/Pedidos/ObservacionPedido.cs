using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Pedidos
{
    public class ObservacionPedido
    {
        public int IdObservacion { get; set; }
        public DateTime Fecha { get; set; }
        public string Descripcion { get; set; }

        public int IdPedido { get; set; }
        public virtual Pedido Pedido { get; set; }
    }
