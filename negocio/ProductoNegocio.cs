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
            ImagenNegocio imgNegocio = new ImagenNegocio();

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

                    if (!(datos.Lector["Descripcion"] is DBNull))
                        aux.Descripcion = (string)datos.Lector["Descripcion"];
                    else
                        aux.Descripcion = "Sin descripción disponible.";

                    aux.Precio = (decimal)datos.Lector["Precio"];

                    if (!(datos.Lector["Costo"] is DBNull))
                        aux.Costo = (decimal)datos.Lector["Costo"];

                    if (!(datos.Lector["Stock"] is DBNull))
                        aux.Stock = (int)datos.Lector["Stock"];
                    else
                        aux.Stock = 0;

                    aux.Estado = (bool)datos.Lector["Estado"];
                    aux.Marca = new Marca();
                    aux.Marca.Id = (int)datos.Lector["IdMarca"];
                    aux.Marca.Nombre = (string)datos.Lector["Marca"];
                    aux.Categoria = new Categoria();
                    aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    aux.Categoria.Nombre = (string)datos.Lector["Categoria"];

                    try
                    {
                        foreach (Imagen img in imgNegocio.listar(aux.Id))
                        {
                            aux.Imagenes.Add(img);

                        }

                    }
                    catch (Exception ex)
                    {
                        throw ex;

                    }

                    if (aux.Imagenes != null && aux.Imagenes.Count() > 0)
                    {
                        aux.ImagenPrincipal = aux.Imagenes[0].Url;
                    }
                    else
                    {
                        aux.ImagenPrincipal = "https://img.icons8.com/pulsar-line/1200/image.jpg";
                    }


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

        public Producto listar(int id)
        {
            Producto aux = new Producto();
            AccesoDatos datos = new AccesoDatos();
            ImagenNegocio imgNegocio = new ImagenNegocio();

            try
            {
                datos.setearProcedimiento("spListarProductoId");
                datos.setearParametros("@id", id);
                datos.ejecutarLectura();
                datos.Lector.Read();

                aux.Id = (int)datos.Lector["Id"];
                aux.Sku = (string)datos.Lector["Sku"];
                aux.Nombre = (string)datos.Lector["Nombre"];

                if (!(datos.Lector["Descripcion"] is DBNull))
                    aux.Descripcion = (string)datos.Lector["Descripcion"];
                else
                    aux.Descripcion = "Sin descripción disponible.";

                aux.Precio = (decimal)datos.Lector["Precio"];

                if (!(datos.Lector["Costo"] is DBNull))
                    aux.Costo = (decimal)datos.Lector["Costo"];

                if (!(datos.Lector["Stock"] is DBNull))
                    aux.Stock = (int)datos.Lector["Stock"];
                else
                    aux.Stock = 0;

                aux.Estado = (bool)datos.Lector["Estado"];
                aux.Marca = new Marca();
                aux.Marca.Id = (int)datos.Lector["IdMarca"];
                aux.Marca.Nombre = (string)datos.Lector["Marca"];
                aux.Categoria = new Categoria();
                aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                aux.Categoria.Nombre = (string)datos.Lector["Categoria"];

                try
                {
                    foreach (Imagen img in imgNegocio.listar(aux.Id))
                    {
                        aux.Imagenes.Add(img);

                    }

                }
                catch (Exception ex)
                {
                    throw ex;

                }

                if (aux.Imagenes != null && aux.Imagenes.Count() > 0)
                {
                    aux.ImagenPrincipal = aux.Imagenes[0].Url;
                }
                else
                {
                    aux.ImagenPrincipal = "https://img.icons8.com/pulsar-line/1200/image.jpg";
                }
                return aux;

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

        public List<Producto> listarActivos()
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();
            ImagenNegocio imgNegocio = new ImagenNegocio();

            try
            {
                datos.setearProcedimiento("spListarProductosActivos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Producto aux = new Producto();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Sku = (string)datos.Lector["Sku"];
                    aux.Nombre = (string)datos.Lector["Nombre"];

                    if (!(datos.Lector["Descripcion"] is DBNull))
                        aux.Descripcion = (string)datos.Lector["Descripcion"];
                    else
                        aux.Descripcion = "Sin descripción disponible.";

                    aux.Precio = (decimal)datos.Lector["Precio"];

                    if (!(datos.Lector["Costo"] is DBNull))
                        aux.Costo = (decimal)datos.Lector["Costo"];

                    if (!(datos.Lector["Stock"] is DBNull))
                        aux.Stock = (int)datos.Lector["Stock"];
                    else
                        aux.Stock = 0;

                    aux.Estado = (bool)datos.Lector["Estado"];
                    aux.Marca = new Marca();
                    aux.Marca.Id = (int)datos.Lector["IdMarca"];
                    aux.Marca.Nombre = (string)datos.Lector["Marca"];
                    aux.Categoria = new Categoria();
                    aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    aux.Categoria.Nombre = (string)datos.Lector["Categoria"];

                    try
                    {
                        foreach (Imagen img in imgNegocio.listar(aux.Id))
                        {
                            aux.Imagenes.Add(img);

                        }

                    }
                    catch (Exception ex)
                    {
                        throw ex;

                    }

                    if (aux.Imagenes != null && aux.Imagenes.Count() > 0)
                    {
                        aux.ImagenPrincipal = aux.Imagenes[0].Url;
                    }
                    else
                    {
                        aux.ImagenPrincipal = "https://img.icons8.com/pulsar-line/1200/image.jpg";
                    }


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
                datos.setearParametros("@sku", producto.Sku);
                datos.setearParametros("@idCategoria", producto.Categoria.Id);
                datos.setearParametros("@idMarca", producto.Marca.Id);
                datos.setearParametros("@nombre", producto.Nombre);
                datos.setearParametros("@descripcion", producto.Descripcion);
                datos.setearParametros("@precio", producto.Precio);
                datos.setearParametros("@costo", producto.Costo == null ? 0 : producto.Costo);
                datos.setearParametros("@stock", producto.Stock);
                datos.setearParametros("@estado", producto.Estado);
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
                datos.setearParametros("@sku", producto.Sku);
                datos.setearParametros("@idCategoria", producto.Categoria.Id);
                datos.setearParametros("@idMarca", producto.Marca.Id);
                datos.setearParametros("@nombre", producto.Nombre);
                datos.setearParametros("@descripcion", producto.Descripcion);
                datos.setearParametros("@precio", producto.Precio);
                datos.setearParametros("@costo", producto.Costo);
                datos.setearParametros("@stock", producto.Stock);
                datos.setearParametros("@estado", producto.Estado);

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

        public void modificar(Producto producto)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spModificarProducto");
                datos.setearParametros("@id", producto.Id);
                datos.setearParametros("@sku", producto.Sku);
                datos.setearParametros("@idCategoria", producto.Categoria.Id);
                datos.setearParametros("@idMarca", producto.Marca.Id);
                datos.setearParametros("@nombre", producto.Nombre);
                datos.setearParametros("@descripcion", producto.Descripcion);
                datos.setearParametros("@precio", producto.Precio);
                datos.setearParametros("@costo", producto.Costo);
                datos.setearParametros("@stock", producto.Stock);
                datos.setearParametros("@estado", producto.Estado);
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

        public void modificarEstado(int id, bool estado)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE PRODUCTOS SET Estado = 0 WHERE Id = " + id);
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

        public void eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("spEliminarProducto");
                datos.setearParametros("@id", id);
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

        public bool checkSku(string sku)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Sku FROM PRODUCTOS");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    if ((string)datos.Lector["Sku"] == sku)
                    {
                        return true;

                    }
                }

                return false;

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
