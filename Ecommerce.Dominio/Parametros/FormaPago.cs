using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Parametros
{
    public class FormaPago
    {
        public int IdFormaPago { get; set; }
        public string Nombre { get; set; }
        public bool Activa { get; set; }
    }
}
