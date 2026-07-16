using EcommerceDominio.Parametros;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class MetodoPagoNegocio
    {
        public List<MetodoPago> Listar()
        {
            List<MetodoPago> lista = new List<MetodoPago>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spListarMetodosPago");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    MetodoPago aux = new MetodoPago();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Estado = (bool)datos.Lector["Estado"];
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

        public void Agregar(MetodoPago metodo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("spAltaMetodoPago");
                datos.setearParametros("@nombre", metodo.Nombre);
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

        public void Modificar(MetodoPago metodo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("spModificarMetodoPago");
                datos.setearParametros("@id", metodo.Id);
                datos.setearParametros("@nombre", metodo.Nombre);
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

        public void EliminarLogico(int id, bool estado)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("spBajaLogicaMetodoPago");
                datos.setearParametros("@id", id);
                datos.setearParametros("@estado", estado);
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
