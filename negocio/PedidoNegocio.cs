using EcommerceDominio.Carrito;
using EcommerceDominio.Usuarios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public static class PedidoNegocio
    {
        public static void Compra(Carrito carrito, Cliente cliente, Direccion direccion)
        {
            AccesoDatos datos = new AccesoDatos();
            int idCompra = 0;

            try
            {
                datos.setearProcedimiento("spAltaPedido");
                datos.setearParametros("idCliente", cliente.Id);
                if(direccion.Id != 0)
                {
                    datos.setearParametros("idDireccion", direccion.Id);
                }
                else
                {
                    datos.setearParametros("idDireccion", DireccionNegocio.AgregarScalar(cliente.Id,direccion));
                }
                datos.setearParametros("idMetodoDePago", 1);
                datos.setearParametros("fecha", DateTime.Now);
                datos.setearParametros("precio", carrito.GetTotal());
                datos.setearParametros("idFormaDeEntrega", 1);
                idCompra = datos.ejecutarAccionScalar();

                foreach(ItemCarrito item in carrito.Items)
                {
                    datos.setearProcedimiento("spAltaItemPedido");
                    datos.setearParametros("idPedido", idCompra);
                    datos.setearParametros("idProducto", item.IdProducto);
                    datos.setearParametros("cantidad", item.Cantidad);
                    datos.setearParametros("precio", item.Subtotal);
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
