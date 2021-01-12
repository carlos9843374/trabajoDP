using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.ComponentModel;
using System.Data;
using System.Drawing;

namespace WindowsFormsApp1
{
    class Conexion
    {
        SqlConnection conn;
        
        //CREAMOS EL METODO DE CONECTAR
        public void Conectar()
        {
            //OBJETO PARA OBTENER LA CONEXION
            conn = new SqlConnection("Data Source=PC;Initial Catalog=Ejemplo;Persist Security Info=True;User ID=sa;Password=temporal");
            conn.Open();
        }

        //CREAMOS EL METODO PARA DESCONECTAR LA BD
        public void Desconectar()
        {
            conn.Close();
        }

        //CREAMOS EL METODO PARA REALIZAR QUERYS
        public string Insertar(int num_distribuidor, string nombre, string apellidop, string apellidoM, int telefono, string calle, int numero, string colonia)
        {
            string salida = "Si se registro la informacion";

            try
            {
                //GUARDAMOS LA FECHA
                DateTime fecha = DateTime.Today;
                
                SqlCommand altaDistr = new SqlCommand("INSERT INTO distributors(num_distribuidor, fecha_registro) VALUES(" + num_distribuidor + ", '"+fecha+"' )", conn);
                altaDistr.ExecuteNonQuery();

                //BUSCAMOS EL ID DEL DISTRIBUIDOR
                string ConsultDist = "SELECT MAX (id_distribuidor) FROM distributors";
                SqlCommand consultDist = new SqlCommand(ConsultDist,conn);

                //GUARDAMOS EL ID EN UNA VARIABLE...
                int lastDistID = Convert.ToInt32(consultDist.ExecuteScalar()); 

                //GUARDAMOS EN LA TABLA PERSONS
                SqlCommand cmd = new SqlCommand("INSERT INTO persons(distribuidor_id, nombre, apellidop, apellidoM, telefono) VALUES("+ lastDistID + ", '"+nombre+"', '"+apellidop+"', '"+apellidoM+"', "+telefono+ ")", conn);
                int FilasAfectadas = cmd.ExecuteNonQuery();

                //OBTENEMOS EL ID DEL USUARIO..
                string Consulta = "SELECT MAX(id_usuario) FROM persons";
                SqlCommand consultCalle = new SqlCommand(Consulta, conn);

                //GUARDAMOS EN LA TABLA CALLES
                int idCaptura = Convert.ToInt32(consultCalle.ExecuteScalar());

                //AGREGAMOS A LA TABLA ADRESS
                SqlCommand altaCalle = new SqlCommand("INSERT INTO addresses(calle, numero, colonia, usuario_id) VALUES('" + calle + "', " + numero + ", '" + colonia + "', " + idCaptura + ")", conn);
                altaCalle.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                salida = "No se pudo guardar la informacion: " + ex.ToString();
            }

            return salida;
        }

        public int personaRegistrada(int num_distribuidor)
        {
            int contador = 0;

            try
            {
                SqlCommand cmd = new SqlCommand("SELECT id_usuario, num_distribuidor, nombre, apellidop, apellidoM " +
                                                "FROM persons p " +
                                                "INNER JOIN distributors d ON p.distribuidor_id = d.id_distribuidor " +
                                                "WHERE d.num_distribuidor = "+ num_distribuidor + "", conn);

                SqlDataReader dr = cmd.ExecuteReader();

                while(dr.Read())
                {
                    contador++;
                }

                dr.Close();


            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudo consultar la persona: "+ex.ToString());
            }

            return contador;
        }

        public int validarDistribuidor(int distribuidor_id)
        {
            int contador = 0;

            try
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM distributors WHERE num_distribuidor = " + distribuidor_id + "", conn);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    contador++;
                }

                dr.Close();


            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudo consultar la persona: " + ex.ToString());
            }

            return contador;
        }


        //METODO PARA ACTUALIZAR EL GRID...
        public void ActualizarGrid(DataGridView dg, String consulta)
        {
            this.Conectar();

            System.Data.DataSet ds = new System.Data.DataSet();

            SqlDataAdapter da = new SqlDataAdapter(consulta, conn);

            da.Fill(ds, "persons");

            dg.DataSource = ds;
            dg.DataMember = "persons";

            this.Desconectar();

        }

        //METODO PARA BUSCAR EL DISTRIBUIDOR...
        public void BuscarDist(int distID, DataGridView dataGrid)
        {
         
            try
            {
                //CREAMOS LA INSTANCIA DEL DATATABLE
                DataTable dt = new DataTable();

                //REALIZAMOS EL COMANDO DEL PRODECURE
                SqlCommand cmd = new SqlCommand("SP_Buscar", conn);

                //EJECUTAMOS EL PROCEDURE
                cmd.CommandType = CommandType.StoredProcedure;

                //ESTABLECEMOS LOS PARAMETROS
                cmd.Parameters.AddWithValue("@num_distribuidor", distID);

                //ADAPTAMOS EL PROCEDIMIENTO...
                SqlDataAdapter sqlData = new SqlDataAdapter(cmd);

                sqlData.Fill(dt);

                dataGrid.DataSource = dt;

                cmd.ExecuteScalar();

            }
            catch (Exception ex)
            {

                MessageBox.Show("No se pudo consultar la persona: " + ex.ToString());
            }

        }
    }
}
