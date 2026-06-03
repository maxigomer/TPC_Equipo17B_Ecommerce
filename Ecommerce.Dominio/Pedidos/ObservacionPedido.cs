using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Pedidos
{
    public class ObservacionPedido 
        public int Id { get; set; }
        public int IdPedido { get; set; }
        public string Observacion { get; set; }

        public virtual Pedido Pedido { get; set; }
    }
}