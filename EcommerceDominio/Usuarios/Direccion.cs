using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Usuarios
{
    public class Direccion
    {
        public int Id { get; set; }
        public int IdCliente { get; set; }
        public string Calle { get; set; }
        public int Numero { get; set; }
        public string Localidad { get; set; }
        public int CodigoPostal { get; set; }
        public string Observaciones { get; set; }

        public virtual Cliente Cliente { get; set; }
    }
}
