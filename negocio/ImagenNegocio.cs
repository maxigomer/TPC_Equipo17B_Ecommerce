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
        public List<Imagen> listar()
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
            AccesoDatos datos = new AccesoDatos();

            try
            {
                foreach (string url in listaUrl)
                {
                    datos.setearProcedimiento("spAltaImagen");
                    datos.setearParametros("@url", url);
                    datos.setearParametros("@idProducto", idProducto);
                    datos.ejecutarAccion();

                }

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
