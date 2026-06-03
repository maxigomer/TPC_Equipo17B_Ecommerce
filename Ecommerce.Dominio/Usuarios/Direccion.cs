using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Usuarios
{
    public class Direccion
    {
        public int IdDireccion { get; set; }
        public string Calle { get; set; }
        public int Numero { get; set; }
        public string Localidad { get; set; }
        public string CodigoPostal { get; set; } // Mejor string, por si tiene letras
        public string Observaciones { get; set; }

        // Relación: Pertenece a un Cliente
        public int IdCliente { get; set; }
        public virtual Cliente Cliente { get; set; }
    }
}
