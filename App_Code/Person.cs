using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace DashBoard
{
    public static class Person
    {
        private static string name = string.Empty;
        private static string position = "Teller";
        private static Int32 islog = 0;

        public static string UserName
        {
            get
            { return name; }
            set
            { name = value;}
        }

        public static Int32 WithUser
        {
            get
            { return islog; }
            set
            { islog = value; }
        }

        public static string Position
        {
            get
            { return position ; }
            set
            { position = value; }
        }




    }
}