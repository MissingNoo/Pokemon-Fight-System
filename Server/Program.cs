using MySqlConnector;

namespace GMS_CSharp_Server
{
    class Program
    {
        static void Main(string[] args)
        {
            Server.log("Connecting to database");
            string constr = "Server=localhost;Username=root;Password=;Database=PFS";
            using var connection = new MySqlConnection(constr);
            try
            {
                connection.Open();
            }
            catch (Exception)
            {
                Server.log("Can't connect to database. Exiting");
                Environment.Exit(1);
            }
            
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
