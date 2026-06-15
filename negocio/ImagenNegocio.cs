using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EcommerceDominio.Catalogo;

namespace negocio
{
    public class ImagenNegocio
    {
        public List<Imagen> listar()//trae todas las imagenes
        {
            List<Imagen> lista = new List<Imagen>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM IMAGENES");
                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    Imagen imagen = new Imagen();
                    imagen.Id = (int)datos.Lector["Id"];
                    imagen.Url = (string)datos.Lector["Url"];
                    imagen.IdProducto = (int)datos.Lector["IdProducto"];

                    lista.Add(imagen);
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

        /* --- CÓDIGO COMENTADO ---
           He comentado esta función por seguridad, ya que usa parámetros, 
           lo cual es una buena práctica.
        */

        /*
        public List<Imagen> listarPorIdProducto(int idProducto)
        {
            List<Imagen> lista = new List<Imagen>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Id, Url, IdProducto FROM IMAGENES WHERE IdProducto = @idProducto");
                datos.setearParametros("@idProducto", idProducto);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Imagen aux = new Imagen();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Url = (string)datos.Lector["Url"];
                    aux.IdProducto = (int)datos.Lector["IdProducto"];

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
        */

        // --- LA OTRA FUNCIÓN (ACTIVA) ---

        public List<Imagen> listar(int id)
        {
            List<Imagen> lista = new List<Imagen>();
            AccesoDatos datos = new AccesoDatos();
            string consulta = "SELECT * FROM IMAGENES WHERE IdProducto = " + id;

            try
            {
                datos.setearConsulta(consulta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Imagen imagen = new Imagen();
                    imagen.Id = (int)datos.Lector["Id"];
                    imagen.Url = (string)datos.Lector["Url"];
                    imagen.IdProducto = (int)datos.Lector["IdProducto"];

                    lista.Add(imagen);
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

        public void agregarImagen(string url, int idProducto)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spAltaImagen");
                datos.setearParametros("@url", url);
                datos.setearParametros("@idProducto", idProducto);
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

        public void agregarImagen(List<string> listaUrl, int idProducto)
        {
            try
            {
                foreach (string url in listaUrl)
                {
                    //datos.setearProcedimiento("spAltaImagen");
                    //datos.setearParametros("@url", url);
                    //datos.setearParametros("@idProducto", idProducto);
                    //datos.ejecutarAccion();
                    //datos.cerrarConexion();
                    agregarImagen(url, idProducto);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
