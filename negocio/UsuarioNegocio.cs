using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EcommerceDominio.Usuarios;

namespace negocio
{
    public static class UsuarioNegocio
    {
        public static bool Login(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_login");
                datos.setearParametros("usuario", usuario.NombreUsuario);
                datos.setearParametros("clave", usuario.Clave);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    usuario.Id = (int)datos.Lector["Id"];
                    usuario.Rol.Id = Convert.ToInt32(datos.Lector["IdRol"]);
                    usuario.Rol.NombreRol = (string)datos.Lector["Rol"];
                    return true;

                }
                else
                {
                    return false;
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
