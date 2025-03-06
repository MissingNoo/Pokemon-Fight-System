using MySqlConnector;

namespace GMS_CSharp_Server
{
    class Program
    {
        public static MySqlConnection? connection;
        public static string constr = "Server=localhost;Username=root;Password=;Database=PFS";
        static void Main(string[] args)
        {
            Server.log("Connecting to database");
            
            connection = new MySqlConnection(constr);
            try
            {
                connection.Open();
            }
            catch (Exception)
            {
                Server.log("Can't connect to database. Exiting");
                Environment.Exit(1);
            }
            connection.Close();
            /*using var command = new MySqlCommand("SELECT * FROM Accounts;", connection);
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                var value = reader.GetValue(0);
                Console.WriteLine(value);
            }*/
            Server.log("Starting Server...");
            Server server = new Server();
            server.StartServer(10103);
            Server.log("Server Started!");
        }
    }
}
