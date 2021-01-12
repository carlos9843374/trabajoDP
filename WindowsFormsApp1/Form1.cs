using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace WindowsFormsApp1
{

    public partial class Form1 : Form
    {
        //OBJETO PARA TRAER LA CONEXION
        Conexion con = new Conexion();
        
        public Form1()
        {
            InitializeComponent();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            txtNombre.CharacterCasing = CharacterCasing.Upper;
        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {
            /*SE HABILITA LA MAYUSCULA AL MOMENTO DE ESCRIBIR*/
            txtApellidoM.CharacterCasing = CharacterCasing.Upper;
        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void txtNumero_TextChanged(object sender, EventArgs e)
        {
            /*SE HABILITA LA MAYUSCULA AL MOMENTO DE ESCRIBIR*/
            txtNumero.CharacterCasing = CharacterCasing.Upper;
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            con.Conectar();

            if (con.validarDistribuidor(Convert.ToInt32(txtIdDist.Text)) > 0)
            {
                //ENVIAMOS COMO PARAMETRO, EL VALOR DEL ID DISTRIBUIDOR Y EL GRID...
                con.BuscarDist(Convert.ToInt32(txtIdDist.Text), this.dataGridView1);
            }
            else
            {
                MessageBox.Show("El distribuidor no esta dado de alta, Intente de nuevo", "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

           
            ////BORRAMOS LOS CAMPOS DE TEXTO...
            this.BorrarTexto();

            //DESCONECTAMOS DE LA BD...
            con.Desconectar();
        }

        private void label2_Click(object sender, EventArgs e)
        {
            
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void txtApellidoP_TextChanged(object sender, EventArgs e)
        {
            /*SE HABILITA LA MAYUSCULA AL MOMENTO DE ESCRIBIR*/
            txtApellidoP.CharacterCasing = CharacterCasing.Upper;
        }

        private void txtCalle_TextChanged(object sender, EventArgs e)
        {
            /*SE HABILITA LA MAYUSCULA AL MOMENTO DE ESCRIBIR*/
            txtCalle.CharacterCasing = CharacterCasing.Upper;
        }

        private void txtColonia_TextChanged(object sender, EventArgs e)
        {
            /*SE HABILITA LA MAYUSCULA AL MOMENTO DE ESCRIBIR*/
            txtColonia.CharacterCasing = CharacterCasing.Upper;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.ActualizarGrid();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            //OBTENEMOS LA CONEXION
            con.Conectar();

            if (con.personaRegistrada(Convert.ToInt32(txtIdDist.Text)) ==0)
            {

                //ENVIAMOS LOS PARAMETROS DE LOS TEXTBOX HACIA LA CLASE INSERTAR...
                con.Insertar(Convert.ToInt32(txtIdDist.Text), txtNombre.Text, txtApellidoP.Text, txtApellidoM.Text, Convert.ToInt32(txtTelefono.Text), txtCalle.Text, Convert.ToInt32(txtNumero.Text), txtColonia.Text);
                MessageBox.Show("Operacion realizada correctamente", "La base de datos a sido modificada", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            else
            {
                //MessageBox.Show("Imposible registrar, El registro ya existe");
                MessageBox.Show("El ID distribuidor ya se encuentra dado de alta, Verifique", "Error del sistema", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }


            //ACTUALIZAMOS EL GRID...
            this.ActualizarGrid();

            ////BORRAMOS LOS CAMPOS DE TEXTO...
            this.BorrarTexto();

            //DESCONECTAMOS DE LA BD...
            con.Desconectar();

        }

        //METODO PARA ACTUALIZAR EL GRID...
        public void ActualizarGrid()
        {
            con.ActualizarGrid(this.dataGridView1, "SELECT num_distribuidor as Numero_Distribuidor, concat(nombre, ' ', apellidop, ' ', apellidoM) as Nombre_Completo, telefono as Telefono, calle as Calle, numero as Numero, colonia as Colonia " +
                "FROM distributors dist " +
                "INNER JOIN persons p ON dist.id_distribuidor = p.distribuidor_id " +
                "INNER JOIN addresses ad ON p.id_usuario = ad.usuario_id " +
                "ORDER BY dist.id_distribuidor ASC");
        }

        //METODO PARA LIMPIAR LOS TEXTOS...
        public void BorrarTexto()
        {
            txtIdDist.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtApellidoM.Text = string.Empty;
            txtApellidoP.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtCalle.Text = string.Empty;
            txtNumero.Text = string.Empty;
            txtColonia.Text = string.Empty;
        }
       
    }
}
