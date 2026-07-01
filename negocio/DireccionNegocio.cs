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
    }
}
