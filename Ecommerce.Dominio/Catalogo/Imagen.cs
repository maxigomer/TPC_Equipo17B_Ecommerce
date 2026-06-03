using System;
using System.Collections.Generic;
using System.Text;

namespace Ecommerce.Dominio.Catalogo
{
    public class Imagen
    {
        public int IdImagen { get; set; }
        public string Url { get; set; }

        public int IdProducto { get; set; }
        public virtual Producto Producto { get; set; }
    }
}
