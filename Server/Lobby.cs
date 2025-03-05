using System.Net.Sockets;
using static GMS_CSharp_Server.Server;

namespace GMS_CSharp_Server
{
    /// <summary>
        /// Handles sessions of clients.
        /// </summary>
        public class Lobby
        {
            public List<SocketHelper>? LobbyClients;
            public String? Map;
            public String Name;
            public String Password;
            private int lastid = 1;
            /// <summary>
            /// Adds two clients and the map to the lobby from matchmaking.
            /// </summary>
            public void SetupLobby(String name, SocketHelper host, SocketHelper client = null)
            {
                LobbyClients = new List<SocketHelper>();
                Name = name;
                AddClient(host);
                if (client != null)
                {
                    AddClient(client);
                }
            }

            public void UpdatePlayers() 
            {
                String PlayerNames = "";
                foreach (var client in LobbyClients)
                {
                    PlayerNames += client.ClientName + ";";
                }
                BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                buffer.Seek(0);
                UInt16 constant_out = 3;
                buffer.Write(constant_out);
                buffer.Write(PlayerNames);
                
                foreach (var client in LobbyClients)
                {
                    client.SendMessage(buffer);
                }
            }
            
            public void AddClient(SocketHelper client) 
            {
                LobbyClients.Add(client);
                client.GameLobby = this;
                client.ClientNumber = lastid;
                lastid++;
                client.IsIngame = true;
                UpdatePlayers();
            }
        }

}