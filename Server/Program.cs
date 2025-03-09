using MySqlConnector;
using MongoDB;
using System.Data.Common;
using MongoDB.Driver;
using MongoDB.Driver.Core.Configuration;
using MongoDB.Bson;


namespace GMS_CSharp_Server
{
    class Program
    {
        public static MySqlConnection? connection;
        static MongoClientSettings dbcon = new MongoClientSettings(){
                Scheme = ConnectionStringScheme.MongoDB,
                Server = new MongoServerAddress("localhost", 27017)
            };
        public static MongoClient? db ;
        static void Main(string[] args)
        {
            Server.log("Connecting to database");
            try
            {
                db = new MongoClient(dbcon);
            }
            catch (System.Exception)
            {
                Server.log("Can't connect to database. Exiting");
                Environment.Exit(1);
            }

            Server.log("Starting Server...");
            Server server = new Server();
            server.StartServer(10103);
            Server.log("Server Started!");
        }
    }
}
