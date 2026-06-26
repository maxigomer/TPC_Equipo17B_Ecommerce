using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public static class BannerNegocio
    {
        public static string Url()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT * FROM BANNERS");
                datos.ejecutarLectura();
                datos.Lector.Read();
                
                return (string)datos.Lector["Url"];
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

        public static void Actualizar(string url)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE BANNERS SET Url = '" + url +"'");
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
