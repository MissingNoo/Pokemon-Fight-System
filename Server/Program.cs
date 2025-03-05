using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GMS_CSharp_Server
{
    class Program
    {
        static void Main(string[] args)
        {
            Server.log("Starting Server...");
            Server server = new Server();
            server.StartServer(10103);
            Server.log("Server Started!");
        }
    }
}
