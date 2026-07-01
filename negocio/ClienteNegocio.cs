using EcommerceDominio.Usuarios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class ClienteNegocio
    {
        public List<Cliente> Listar()
        {
            List<Cliente> lista = new List<Cliente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre, Apellido, Dni, Email, Telefono FROM CLIENTES");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Cliente aux = new Cliente();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (string)datos.Lector["Dni"];
                    aux.Email = (string)datos.Lector["Email"];

                    //if (!(datos.Lector["Telefono"] != DBNull.Value))
                    if (datos.Lector["Telefono"] != DBNull.Value)
                    {
                        aux.Telefono = (string)datos.Lector["Telefono"];
                    }
                    else
                    {
                        aux.Telefono = "-";
                    }

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public Cliente ObtenerPorUsuario(int idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            Cliente cliente = null;

            try
            {
                datos.setearConsulta(@"SELECT Id, Nombre, Apellido, Dni, Email, Telefono, IdUsuario FROM Clientes WHERE IdUsuario = @IdUsuario");

                datos.setearParametros("IdUsuario", idUsuario);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    cliente = new Cliente();

                    cliente.Id = (int)datos.Lector["Id"];
                    cliente.Nombre = (string)datos.Lector["Nombre"];
                    cliente.Apellido = (string)datos.Lector["Apellido"];

                    if (datos.Lector["Dni"] != DBNull.Value)
                        cliente.DNI = datos.Lector["Dni"].ToString();

                    cliente.Email = (string)datos.Lector["Email"];

                    if (datos.Lector["Telefono"] != DBNull.Value)
                        cliente.Telefono = datos.Lector["Telefono"].ToString();
                    else
                        cliente.Telefono = "-";
                    cliente.Usuario.Id = (int)datos.Lector["IdUsuario"];
                }

                return cliente;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Modificar(Cliente cliente)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"UPDATE CLIENTES SET Nombre = @Nombre, Apellido = @Apellido, Dni = @Dni, Email = @Email, Telefono = @Telefono WHERE IdUsuario = @IdUsuario");

                datos.setearParametros("Nombre", cliente.Nombre);
                datos.setearParametros("Apellido", cliente.Apellido);
                datos.setearParametros("Dni", cliente.DNI);
                datos.setearParametros("Email", cliente.Email);

                if (string.IsNullOrWhiteSpace(cliente.Telefono) || cliente.Telefono == "-")
                    datos.setearParametros("Telefono", DBNull.Value);
                else
                    datos.setearParametros("Telefono", cliente.Telefono);

                datos.setearParametros("IdUsuario", cliente.Usuario.Id);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
