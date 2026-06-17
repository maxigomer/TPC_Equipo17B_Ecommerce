using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EcommerceDominio.Catalogo;

namespace negocio
{
    public class CategoriaNegocio
    {
        public List<Categoria> listar()
        {
            AccesoDatos datos = new AccesoDatos();
            List<Categoria> lista = new List<Categoria>();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre FROM CATEGORIAS");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Categoria aux = new Categoria();

                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];

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

        public void agregarConSP(Categoria categoria)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spAltaCategoria");
                datos.setearParametros("@nombre", categoria.Nombre);
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

        public int agregarScalar(string nombre)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spAltaCategoriaScalar");
                datos.setearParametros("@nombre", nombre);

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

        public void check()
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spCheckCategorias");
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
    }
}
