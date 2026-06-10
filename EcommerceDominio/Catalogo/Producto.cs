using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Catalogo
{
    public class Producto
    {
        public int Id { get; set; }
        public string Sku { get; set; }
        public Categoria Categoria { get; set; }
        public Marca Marca { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        public decimal Costo { get; set; }
        public int Stock { get; set; }
        public bool Estado { get; set; }

        public virtual ICollection<Imagen> Imagenes { get; set; } = new List<Imagen>();
    }
}
