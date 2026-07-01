using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public static class CheckoutNegocio
    {
        public static bool ProcesarCheckout(string numeroTarjeta, string titular, string vencimiento, string cvv, decimal monto)
            {
                try
                {
                    // Validación mínima: que no venga vacío
                    if (string.IsNullOrWhiteSpace(numeroTarjeta) ||
                        string.IsNullOrWhiteSpace(titular) ||
                        string.IsNullOrWhiteSpace(vencimiento) ||
                        string.IsNullOrWhiteSpace(cvv))
                    {
                        return false;
                    }

                    // Validación básica de longitud (simulación realista)
                    if (numeroTarjeta.Length < 13 || numeroTarjeta.Length > 19)
                        return false;

                    if (cvv.Length < 3)
                        return false;

                    if (monto <= 0)
                        return false;

                    // Simulación: siempre aprobado si pasa validaciones
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }
    }
