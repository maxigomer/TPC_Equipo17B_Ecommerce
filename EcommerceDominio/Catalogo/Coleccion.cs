using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Catalogo
{
    public class Coleccion
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public int IdCriterio { get; set; }
        public string Criterio {  get; set; }
        public bool Estado { get; set; }

    }
}
