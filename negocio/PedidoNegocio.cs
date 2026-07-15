using EcommerceDominio.Carrito;
using EcommerceDominio.Pedidos;
using EcommerceDominio.Usuarios;
using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public static class PedidoNegocio
    {
        public static void Compra(Carrito carrito, Cliente cliente, Direccion direccion, int metodoPago)
        {
            AccesoDatos datos = new AccesoDatos();
            int idCompra = 0;

            try
            {
                datos.setearProcedimiento("spAltaPedido");
                datos.setearParametros("idCliente", cliente.Id);
                if (direccion.Id != 0)
                {
                    if (direccion.Id == -1)
                    {
                        datos.setearParametros("idDireccion", DBNull.Value);

                    }
                    else
                    {
                        datos.setearParametros("idDireccion", direccion.Id);

                    }
                }
                else
                {
                    datos.setearParametros("idDireccion", DireccionNegocio.AgregarScalar(cliente.Id, direccion));
                }
                datos.setearParametros("idMetodoDePago", metodoPago);
                datos.setearParametros("fecha", DateTime.Now);
                datos.setearParametros("precio", carrito.GetTotal());
                datos.setearParametros("idFormaDeEntrega", direccion.Id == -1 ? 2 : 1);
                idCompra = datos.ejecutarAccionScalar();

                foreach (ItemCarrito item in carrito.Items)
                {
                    datos.cerrarConexion();
                    datos.setearProcedimiento("spAltaItemPedido");
                    datos.setearParametros("idPedido", idCompra);
                    datos.setearParametros("idProducto", item.IdProducto);
                    datos.setearParametros("cantidad", item.Cantidad);
                    datos.setearParametros("precio", item.Subtotal);
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
        public static void Compra(Carrito carrito, Cliente cliente, Direccion direccion, int metodoPago, string dniTransferencia)
        {
            AccesoDatos datos = new AccesoDatos();
            int idCompra = 0;

            try
            {
                datos.setearProcedimiento("spAltaPedido");
                datos.setearParametros("idCliente", cliente.Id);
                if (direccion.Id != 0)
                {
                    if (direccion.Id == -1)
                    {
                        datos.setearParametros("idDireccion", DBNull.Value);

                    }
                    else
                    {
                        datos.setearParametros("idDireccion", direccion.Id);

                    }
                }
                else
                {
                    datos.setearParametros("idDireccion", DireccionNegocio.AgregarScalar(cliente.Id, direccion));
                }
                datos.setearParametros("idMetodoDePago", metodoPago);
                datos.setearParametros("fecha", DateTime.Now);
                datos.setearParametros("precio", carrito.GetTotal());
                datos.setearParametros("idFormaDeEntrega", direccion.Id == -1 ? 2 : 1);
                idCompra = datos.ejecutarAccionScalar();

                foreach (ItemCarrito item in carrito.Items)
                {
                    datos.cerrarConexion();
                    datos.setearProcedimiento("spAltaItemPedido");
                    datos.setearParametros("idPedido", idCompra);
                    datos.setearParametros("idProducto", item.IdProducto);
                    datos.setearParametros("cantidad", item.Cantidad);
                    datos.setearParametros("precio", item.Subtotal);
                    datos.ejecutarAccion();
                }

                if (metodoPago == 2)
                {
                    datos.cerrarConexion();
                    datos.setearConsulta("INSERT INTO OBSERVACIONES_PEDIDOS VALUES('" + idCompra + "', 'DNI del que realiza la transferencia: " + dniTransferencia + "');");
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

        public static List<Pedido> Listar()
        {
            AccesoDatos datos = new AccesoDatos();
            List<Pedido> lista = new List<Pedido>();

            try
            {
                datos.setearConsulta("SELECT P.Id,P.IdCliente,C.Nombre,C.Apellido,P.IdDireccion,P.IdMetodoDePago,P.Fecha,P.Precio,P.IdFormaDeEntrega,P.IdEstado, E.Estado FROM PEDIDOS P, CLIENTES C, ESTADOS_DE_PEDIDO E WHERE P.IdCliente = C.Id AND P.IdEstado = E.Id");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Pedido aux = new Pedido();

                    aux.Id = (int)datos.Lector["Id"];
                    aux.Cliente.Id = (int)datos.Lector["IdCliente"];
                    aux.Cliente.Nombre = (string)datos.Lector["Nombre"];
                    aux.Cliente.Apellido = (string)datos.Lector["Apellido"];
                    if (!(datos.Lector["idDireccion"] is DBNull))
                    {
                        aux.IdDireccion = (int)datos.Lector["IdDireccion"];
                        aux.Direccion.Id = (int)datos.Lector["IdDireccion"];

                    }
                    else
                    {
                        aux.IdDireccion = -1;
                        aux.Direccion.Id = -1;
                    }
                    aux.IdMetodoDePago = (int)datos.Lector["IdMetodoDePago"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.IdFormaEntrega = (int)datos.Lector["IdFormaDeEntrega"];
                    aux.IdEstado = Convert.ToInt32(datos.Lector["IdEstado"]);
                    aux.Estado = (string)datos.Lector["Estado"];
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

        public static Pedido Listar(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT P.Id,P.IdCliente,C.Nombre,C.Apellido,P.IdDireccion,P.IdMetodoDePago,P.Fecha,P.Precio,P.IdFormaDeEntrega,P.IdEstado, E.Estado FROM PEDIDOS P, CLIENTES C, ESTADOS_DE_PEDIDO E WHERE P.IdCliente = C.Id AND P.IdEstado = E.Id AND P.Id = " + id);
                datos.ejecutarLectura();
                datos.Lector.Read();

                Pedido aux = new Pedido();

                aux.Id = (int)datos.Lector["Id"];
                aux.Cliente.Id = (int)datos.Lector["IdCliente"];
                aux.Cliente.Nombre = (string)datos.Lector["Nombre"];
                aux.Cliente.Apellido = (string)datos.Lector["Apellido"];
                if (!(datos.Lector["idDireccion"] is DBNull))
                {
                    aux.IdDireccion = (int)datos.Lector["IdDireccion"];
                    aux.Direccion.Id = (int)datos.Lector["IdDireccion"];

                }
                else
                {
                    aux.IdDireccion = -1;
                    aux.Direccion.Id = -1;
                }
                aux.IdMetodoDePago = (int)datos.Lector["IdMetodoDePago"];
                aux.Fecha = (DateTime)datos.Lector["Fecha"];
                aux.Precio = (decimal)datos.Lector["Precio"];
                aux.IdFormaEntrega = (int)datos.Lector["IdFormaDeEntrega"];
                aux.IdEstado = Convert.ToInt32(datos.Lector["IdEstado"]);
                aux.Estado = (string)datos.Lector["Estado"];

                datos.cerrarConexion();

                datos.setearConsulta("SELECT I.Id,I.IdPedido, I.IdProducto,I.Cantidad, I.Precio, P.Sku, P.Nombre, Img.Url FROM ITEM_PEDIDOS I \r\nINNER JOIN PRODUCTOS P ON I.IdProducto = P.Id\r\nOUTER APPLY( SELECT TOP 1 Url FROM IMAGENES WHERE IdProducto = I.IdProducto ORDER BY Id) Img WHERE I.IdPedido = " + id);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ItemPedido item = new ItemPedido();
                    item.Id = (int)datos.Lector["Id"];
                    item.IdPedido = (int)datos.Lector["IdPedido"];
                    item.IdProducto = (int)datos.Lector["IdProducto"];
                    item.Cantidad = Convert.ToInt32(datos.Lector["Cantidad"]);
                    item.Precio = (decimal)datos.Lector["Precio"];
                    item.Sku = (string)datos.Lector["Sku"];
                    item.Nombre = (string)datos.Lector["Nombre"];
                    item.Imagen = (string)datos.Lector["Url"];

                    aux.Items.Add(item);


                }
                return aux;


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

        public static void ListarObservaciones(Pedido pedido)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT * FROM OBSERVACIONES_PEDIDOS WHERE IdPedido = " + pedido.Id);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ObservacionPedido aux = new ObservacionPedido();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.IdPedido = (int)datos.Lector["IdPedido"];
                    aux.Observacion = (string)datos.Lector["Observacion"];

                    pedido.Observaciones.Add(aux);

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

        public static void AgregarObservacion(ObservacionPedido obs)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("INSERT INTO OBSERVACIONES_PEDIDOS (IdPedido,Observacion) VALUES (@idPedido,@observacion)");
                datos.setearParametros("@idPedido", obs.IdPedido);
                datos.setearParametros("@observacion", obs.Observacion);
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
