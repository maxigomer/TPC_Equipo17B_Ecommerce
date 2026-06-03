using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Usuarios
{
    public class Cliente
    {
        public int IdCliente { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }

        // Clave foránea al Usuario
        public int IdUsuario { get; set; }
        public virtual Usuario Usuario { get; set; }

        // Relaciones: Un cliente tiene muchas direcciones y muchos pedidos
        public virtual ICollection<Direccion> Direcciones { get; set; } = new List<Direccion>();
        public virtual ICollection<Pedido> Pedidos { get; set; } = new List<Pedido>();
    }
}
