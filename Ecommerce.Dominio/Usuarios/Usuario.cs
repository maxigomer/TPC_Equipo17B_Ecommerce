using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Usuarios
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string NombreUsuario { get; set; } // En tu doc dice "Usuario"
        public string Contrasena { get; set; } // En C# evitamos la "ñ"
        public int Rol { get; set; } // Ej: 1 = Cliente, 2 = Admin

        // Relación 1 a 1 con el Cliente
        public virtual Cliente Cliente { get; set; }
    }
}
