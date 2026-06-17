using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EcommerceDominio.Catalogo
{
    public class Imagen
    {
        public int Id { get; set; }
        public string Url { get; set; }
        public int IdProducto { get; set; }

        public virtual Producto Producto { get; set; }

        public Imagen(string url)
        {
            Url = url;
            Id = 0;

        }

        public Imagen()
        {

        }
    }
}
