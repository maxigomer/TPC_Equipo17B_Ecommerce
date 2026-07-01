using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Pedidos
{
    public class ObservacionPedido
    {
        public int Id { get; set; }
        public int IdPedido { get; set; }
        public string Observacion { get; set; }
    }
}
