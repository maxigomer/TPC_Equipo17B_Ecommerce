using EcommerceDominio.Carrito;
using EcommerceDominio.Usuarios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public static class DireccionNegocio
    {
        public static int AgregarScalar(int idCliente, Direccion direccion)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spAltaDireccion");
                datos.setearParametros("idCliente", idCliente);
                datos.setearParametros("calle", direccion.Calle);
                datos.setearParametros("numero", direccion.Numero);
                datos.setearParametros("localidad", direccion.Localidad);
                datos.setearParametros("codigoPostal", direccion.CodigoPostal);
                datos.setearParametros("observaciones", direccion.Observaciones);

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

        public static Direccion Listar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            Direccion direccion = new Direccion();

            try
            {
                datos.setearConsulta("SELECT * FROM DIRECCIONES WHERE Id = " + id);
                datos.ejecutarLectura();
                datos.Lector.Read();

                direccion.Id = id;
                direccion.IdCliente = (int)datos.Lector["IdCliente"];
                direccion.Calle = (string)datos.Lector["Calle"];
                direccion.Numero = (int)datos.Lector["Numero"];
                direccion.Localidad = (string)datos.Lector["Localidad"];
                direccion.CodigoPostal = (string)datos.Lector["CodigoPostal"];
                direccion.Observaciones = (string)datos.Lector["Observaciones"];

                return direccion;

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
