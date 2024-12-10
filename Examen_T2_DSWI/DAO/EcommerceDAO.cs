using Examen_T2_DSWI.Models;
using System.Data.SqlClient;
using System.Data;

namespace Examen_T2_DSWI.DAO
{
    public class EcommerceDAO
    {
        private string cad_cn;
        public EcommerceDAO(IConfiguration cfg)
        {
            cad_cn = cfg.GetConnectionString("cn1")!;
        }

        public List<Articulos> GetProductos()
        {
            var lista = new List<Articulos>();
            var dr =
                SqlHelper.ExecuteReader(cad_cn, "PA_LISTAR_ARTICULOS");
            //
            while (dr.Read())
            {
                lista.Add(
                           new Articulos()
                           {
                               cod_art = dr.GetString(0),
                               nom_art = dr.GetString(1),
                               pre_art = dr.GetDecimal(2),
                               stk_art = dr.GetInt32(3)
                           });
            }
            dr.Close();
            //
            return lista;
        }

        public Articulos BuscarProducto(string codigo)
        {
            var buscado = GetProductos()
                            .Find(p => p.cod_art.Equals(codigo));

            return buscado!;
        }

        public List<Clientes> GetClientes()
        {
            var lista = new List<Clientes>();
            //
            var dr =
                SqlHelper.ExecuteReader(cad_cn, "PA_LISTAR_CLIENTES_CC");
            //
            while (dr.Read())
            {
                lista.Add(new Clientes()
                {
                    cod_cli = dr.GetString(0),
                    nom_cli = dr.GetString(1)
                });
            }
            dr.Close();
            //
            return lista;
        }



        public IEnumerable<Articulos> listarArticulos(String nombre)
        {
            List<Articulos> lista = new List<Articulos>();
            using (SqlConnection cn = new SqlConnection(cad_cn))
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("FILTRAR_PROD", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@NOMBRE", nombre);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    lista.Add(new Articulos()
                    {
                        cod_art = dr.GetString(0),
                        nom_art = dr.GetString(1),
                        pre_art = dr.GetDecimal(2),
                        stk_art = dr.GetInt32(3)

                    });


                }
                dr.Close();  // cerramos conexion 
                return lista;


            }

        }
    }
}
