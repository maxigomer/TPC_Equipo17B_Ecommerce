using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Catalogo
{
    public class Categoria
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }

        public virtual ICollection<Producto> Productos { get; set; } = new List<Producto>();
    }
}
