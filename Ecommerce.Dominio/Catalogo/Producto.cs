using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Catalogo
{
    public class Producto
    {
        public int Id { get; set; }
        public string Sku { get; set; }
        public int IdCategoria { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        public decimal Costo { get; set; }
        public int Stock { get; set; }
        public bool Estado { get; set; }

        public virtual Categoria Categoria { get; set; }
        public virtual ICollection<Imagen> Imagenes { get; set; } = new List<Imagen>();
    }
}
