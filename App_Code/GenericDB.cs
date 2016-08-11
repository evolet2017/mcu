using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Configuration;
using System.Xml;
using System.IO;

namespace MBv8Web
{
    //public connectionstring = ConfigurationManager.ConnectionStrings["SQLTest"].ConnectionString;
    public static class GenericDB
    {
        static GenericDB()
        {
            // - April 11, 2014 - reyjie.roque
            //   - Custom Class for Database Access
            // - June 4, 2014 - reyjie.roque
            //   - Added GetXML
            // - June 5, 2014 - reyjie.roque
            //   - Added WriteXML
        }

        public static string GetXML(string groupie, string propertie)
        {
            string path = System.AppDomain.CurrentDomain.BaseDirectory;
            path = path + "appconfig.xml";
            string retval = string.Empty;
            if (File.Exists(path))
            {
                XmlTextReader reader = new XmlTextReader(path);
                reader.MoveToContent();
                reader.ReadToDescendant(groupie);
                retval = reader.GetAttribute(propertie);
                //Response.Cookies["dbserver"].Value = reader.GetAttribute("dbserver");
                //Response.Cookies["dbport"].Value = reader.GetAttribute("port");
                reader.Close();
            }
            return retval;
        }

        public static void WriteXML(int id, string valuie)
        {
            string path = System.AppDomain.CurrentDomain.BaseDirectory;
            path = path + "appconfig.xml";

            if (File.Exists(path))
            {
                XmlDocument _xmldoc = new XmlDocument();
                FileStream fs = new FileStream(path, FileMode.Open, FileAccess.ReadWrite);

                _xmldoc.Load(fs);
                fs.Close();
                // Attributes
                // 0 = dbserver
                // 1 = dbport
                // 2 = timeout
                // 3 = connectionstring
                _xmldoc.DocumentElement.ChildNodes[0].Attributes[id].InnerText = valuie;

                FileStream fsw = new FileStream(path, FileMode.Truncate, FileAccess.ReadWrite, FileShare.ReadWrite);
                _xmldoc.Save(fsw);
                fsw.Close();

                _xmldoc = null;
            }
                    
        }
        public static string pr(string s, int cnt)
        {
            //char ss = @"\u00a0";
            return s.PadRight( cnt, ' ' );
        }

        public static Int32 ExecuteNonQuery(String connectionString, String commandText,
          CommandType commandType, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(commandText, conn))
                {
                    // There're three command types: StoredProcedure, Text, TableDirect. The TableDirect 
                    // type is only for OLE DB.  
                    cmd.CommandType = commandType;
                    cmd.Parameters.AddRange(parameters);

                    conn.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        // Set the connection, command, and then execute the command and only return one value.
        public static Object ExecuteScalar(String connectionString, String commandText,
            CommandType commandType, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(commandText, conn))
                {
                    cmd.CommandType = commandType;
                    cmd.Parameters.AddRange(parameters);

                    conn.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }

        // Set the connection, command, and then execute the command with query and return the reader.
        public static SqlDataReader ExecuteReader(String connectionString, String commandText,
            CommandType commandType, params SqlParameter[] parameters)
        {
            SqlConnection conn = new SqlConnection(connectionString);

            using (SqlCommand cmd = new SqlCommand(commandText, conn))
            {
                cmd.CommandType = commandType;
                cmd.Parameters.AddRange(parameters);

                conn.Open();
                // When using CommandBehavior.CloseConnection, the connection will be closed when the 
                // IDataReader is closed.
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                return reader;
            }
        }
        // CommandType = CommandType.StoredProcedure / CommandType.TableDirect / CommandType.Text (Default)
        public static SqlDataReader ExecSQL(String connectionString, String commandText, CommandType commandType = CommandType.Text )
        {
            SqlConnection conn = new SqlConnection(connectionString);

            using (SqlCommand cmd = new SqlCommand(commandText, conn))
            {
               cmd.CommandType = commandType;
               // cmd.Parameters.AddRange(parameters);

                conn.Open();
                // When using CommandBehavior.CloseConnection, the connection will be closed when the 
                // IDataReader is closed.
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                return reader;
            }
        }

        public static bool Exec(string connectionString, String commandText)
        {
            SqlConnection conn = new SqlConnection(connectionString);
            using (SqlCommand cmd = new SqlCommand(commandText, conn))
            {
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
                catch
                {
                    return false;
                }
                // When using CommandBehavior.CloseConnection, the connection will be closed when the 
                // IDataReader is closed.
             
            }
        }

        public static DataSet ExecSQL(string cmd)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLTest"].ConnectionString);
            SqlDataAdapter daCust = new SqlDataAdapter(cmd.ToLower(), con);
            DataSet ds = new DataSet();
            daCust.Fill(ds);
            return ds;
        }

        public static string Execute(string cmd)
        {
            //ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString
            //@"Data Source=.\MSSQL2012;Initial Catalog=MBv8Ledger;User ID=sa;Password=1"
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLTest"].ConnectionString);
            SqlDataAdapter daCust = new SqlDataAdapter(cmd.ToLower(), con);
            DataTable dt = new DataTable();
            daCust.Fill(dt);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }
      // using execute reader
      //   String commandText = "dbo.GetDepartmentsOfSpecifiedYear";

      //// Specify the year of StartDate
      //  SqlParameter parameterYear = new SqlParameter("@Year", SqlDbType.Int);
      //  parameterYear.Value = year;

      //// When the direction of parameter is set as Output, you can get the value after 
      //// executing the command.

      // SqlParameter parameterBudget = new SqlParameter("@BudgetSum", SqlDbType.Money);
      // parameterBudget.Direction = ParameterDirection.Output;

      // using (SqlDataReader reader = SqlHelper.ExecuteReader(connectionString, commandText,
      //    CommandType.StoredProcedure, parameterYear, parameterBudget)) {
      //   Console.WriteLine("{0,-20}{1,-20}{2,-20}{3,-20}", "Name", "Budget", "StartDate",
      //       "Administrator");
      //   while (reader.Read()) {
      //      Console.WriteLine("{0,-20}{1,-20:C}{2,-20:d}{3,-20}", reader["Name"],
      //          reader["Budget"], reader["StartDate"], reader["Administrator"]);
      //   }
      //
      //Console.WriteLine("{0,-20}{1,-20:C}", "Sum:", parameterBudget.Value);
    }

    public static class UserManagement
    {

        private static string username = string.Empty;
        private static string password = string.Empty;
        private static string email = string.Empty;
        private static string firstname = string.Empty;
        private static string lastname = string.Empty;
        private static string picture = string.Empty;

        static UserManagement()
        {
            //
        }

        public static string Username
        {
            get { return username; }
            set { username = value; }
        }
        public static string Password
        {
            get { return password; }
            set { password = value; }
        }
        public static string Email
        {
            get { return email; }
            set { email = value; }
        }
        public static string Firstname
        {
            get { return firstname; }
            set { firstname = value; }
        }
        public static string Lastname
        {
            get { return lastname; }
            set { lastname = value; }
        }
        public static string Picture
        {
            get { return picture; }
            set { picture = value; }
        }

        public static void ReloadUser()
        {
            //username = Request.Cookies["activeid"].Value;
            //password = "";
            //firstname = Request.Cookies["activeuser"].Value;
            //lastname = Request.Cookies["activelast"].Value;
            //email = Request.Cookies["activeemail"].Value;            
        }

        public static bool UpdateUser()
        {
            string cmd = "UPDATE [usertable] SET password='"+password+"',firstname='"+firstname+"',lastname='"+lastname+"',email='"+email+"',image='"+picture+"' WHERE username='"+username+"'";
            //alert(cmd);
            //System.Console(cmd);
            try
            {
                GenericDB.ExecSQL(cmd);
                return true;
            }
            catch { return false; }

        }



    }
 



}