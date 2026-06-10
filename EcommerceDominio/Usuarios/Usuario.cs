using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Usuarios
{
    public class Usuario
    {
        public int Id { get; set; }
        public string NombreUsuario { get; set; }
        public string Clave { get; set; }

        public int IdRol { get; set; }
        public virtual Rol Rol { get; set; }

        public virtual Cliente Cliente { get; set; }
    }
}
