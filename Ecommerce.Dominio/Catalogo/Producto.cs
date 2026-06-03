using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Catalogo
{
    public class Producto
    {
        public int IdProducto { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioVenta { get; set; }
        public int Stock { get; set; }
        public bool Estado { get; set; } // true = Activo, false = Inactivo

        // Relación: Pertenece a una Categoría
        public int IdCategoria { get; set; }
        public virtual Categoria Categoria { get; set; }

        // Relación: Puede tener muchas Imágenes (opcional según el requerimiento, pero recomendado)
        public virtual ICollection<Imagen> Imagenes { get; set; } = new List<Imagen>();
    }
}
