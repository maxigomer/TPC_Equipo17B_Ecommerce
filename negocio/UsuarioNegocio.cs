using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Runtime.Remoting;
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

        public static bool CheckMail(string mail)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM USUARIOS WHERE Usuario = '" + mail +"'");
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
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

        public static Cliente GetCliente(int idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            Cliente cliente = new Cliente();
            try
            {
                datos.setearConsulta("SELECT Id, Nombre, Apellido, Dni, Email, Telefono FROM CLIENTES WHERE IdUsuario = " + idUsuario);
                datos.ejecutarLectura();
                datos.Lector.Read();

                cliente.Nombre = (string)datos.Lector["Nombre"];
                cliente.Apellido = (string)datos.Lector["Apellido"];
                if (!(datos.Lector["Dni"] is DBNull))
                    cliente.DNI = (string)datos.Lector["Dni"];
                else
                    cliente.DNI = "";
                cliente.Email = (string)datos.Lector["Email"];
                if (!(datos.Lector["Telefono"] is DBNull))
                    cliente.Telefono = (string)datos.Lector["Telefono"];
                else
                    cliente.Telefono = "";

                return cliente;

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

        public static void Registrar(Cliente cliente)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("spRegistrarCliente");
                datos.setearParametros("@nombre", cliente.Nombre);
                datos.setearParametros("@apellido", cliente.Apellido);
                datos.setearParametros("@dni", cliente.DNI == null ? "" : cliente.DNI);
                datos.setearParametros("@email", cliente.Email);
                datos.setearParametros("@telefono", cliente.Telefono);
                datos.setearParametros("@clave", cliente.Usuario.Clave);
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
