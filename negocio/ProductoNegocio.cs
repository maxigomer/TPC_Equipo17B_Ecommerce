using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EcommerceDominio.Catalogo;

namespace negocio
{
    public class ProductoNegocio
    {

        public List<Producto> listar()
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spListarProductos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Producto aux = new Producto();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Sku = (string)datos.Lector["Sku"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    if (!(datos.Lector["Costo"] is DBNull))
                        aux.Costo = (decimal)datos.Lector["Costo"];
                    aux.Stock = (int)datos.Lector["Stock"];
                    aux.Estado = (bool)datos.Lector["Estado"];
                    aux.Marca = new Marca();
                    aux.Marca.Id = (int)datos.Lector["IdMarca"];
                    aux.Marca.Nombre = (string)datos.Lector["Marca"];
                    aux.Categoria = new Categoria();
                    aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    aux.Categoria.Nombre = (string)datos.Lector["Categoria"];

                    lista.Add(aux);
                }

                return lista;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }

        public void agregar(Producto producto)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spAltaProducto");
                datos.setearParametros("@sku",producto.Sku);
                datos.setearParametros("@idCategoria",producto.Categoria.Id);
                datos.setearParametros("@idMarca",producto.Marca.Id);
                datos.setearParametros("@nombre",producto.Nombre);
                datos.setearParametros("@descripcion",producto.Descripcion);
                datos.setearParametros("@precio",producto.Precio);
                datos.setearParametros("@costo",producto.Costo);
                datos.setearParametros("@stock",producto.Stock);
                datos.setearParametros("@estado",producto.Estado);
                datos.ejecutarAccion();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public int agregarScalar(Producto producto)
        {

            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spAltaProductoScalar");
                datos.setearParametros("@sku",producto.Sku);
                datos.setearParametros("@idCategoria",producto.Categoria.Id);
                datos.setearParametros("@idMarca",producto.Marca.Id);
                datos.setearParametros("@nombre",producto.Nombre);
                datos.setearParametros("@descripcion",producto.Descripcion);
                datos.setearParametros("@precio",producto.Precio);
                datos.setearParametros("@costo",producto.Costo);
                datos.setearParametros("@stock",producto.Stock);
                datos.setearParametros("@estado",producto.Estado);

                return datos.ejecutarAccionScalar();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }



    }
}
