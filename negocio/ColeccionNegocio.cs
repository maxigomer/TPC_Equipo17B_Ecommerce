using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EcommerceDominio.Catalogo;

namespace negocio
{
    public class ColeccionNegocio
    {

        public List<Coleccion> listar()
        {
            AccesoDatos datos = new AccesoDatos();
            List<Coleccion> lista = new List<Coleccion>();

            try
            {
                datos.setearConsulta("SELECT * FROM COLECCIONES_MENU");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Coleccion aux = new Coleccion();

                    aux.Id = (int)datos.Lector["Id"];
                    if (datos.Lector["Nombre"] is DBNull)
                    {
                        aux.Nombre = "";
                    }
                    else
                    {
                        aux.Nombre = (string)datos.Lector["Nombre"];
                    }
                    if (datos.Lector["IdCriterio"] is DBNull)
                    {
                        aux.IdCriterio = 0;
                    }
                    else
                    {
                        aux.IdCriterio = (int)datos.Lector["IdCriterio"];
                    }

                    if (datos.Lector["Criterio"] is DBNull)
                    {
                        aux.Criterio = "";
                    }
                    else
                    {
                        aux.Criterio = (bool)datos.Lector["Criterio"] ? "Categoria" : "Marca";
                    }
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

        public void Actualizar(List<Coleccion> colecciones)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                foreach (Coleccion coleccion in colecciones)
                {
                    datos.setearProcedimiento("spActualizarColecciones");
                    datos.setearParametros("id", coleccion.Id);
                    datos.setearParametros("nombre", coleccion.Nombre);

                    if(coleccion.IdCriterio == 0)
                    {
                        datos.setearParametros("idCriterio", DBNull.Value);
                    }
                    else
                    {
                        datos.setearParametros("idCriterio", coleccion.IdCriterio);
                    }

                    if (coleccion.Criterio != "")
                    {
                        datos.setearParametros("criterio", coleccion.Criterio == "Categoria" ? true : false);
                    }
                    else
                    {
                        datos.setearParametros("criterio", DBNull.Value);
                    }


                    datos.setearParametros("estado", coleccion.Estado);

                    datos.ejecutarAccion();
                    datos.cerrarConexion();
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
