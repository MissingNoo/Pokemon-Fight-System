using System.Net.Sockets;
using System.Text.Json;

namespace GMS_CSharp_Server
{
    public class PlayerData {
        public string Name { get; set; }
        public string Playmat { get; set; }
        public string Deck { get; set; }
        public float Portrait { get; set; }
        public string Version { get; set; }
    }
    public class SocketHelper
        {
            Queue<BufferStream> WriteQueue = new Queue<BufferStream>();
            public Thread ReadThread;
            public Thread WriteThread;
            public Thread AbortThread;
            public System.Net.Sockets.TcpClient MscClient;
            public Server ParentServer;
            public string ClientName = "";
            public int ClientNumber = 0;
            public Lobby GameLobby;
            public bool IsSearching = false;
            public bool IsIngame = false;
            int BufferSize = Server.BufferSize;
            int BufferAlignment = Server.BufferAlignment;
            public int HandSize = 0;
            public string TalentCard = "undefined";
            public PlayerData? playerData;
            /// <summary>
            /// Starts the given client in two threads for reading and writing.
            /// </summary>
            public void StartClient(TcpClient client, Server server)
            {
                //Sets client variable.
                MscClient = client;
                MscClient.SendBufferSize = BufferSize;
                MscClient.ReceiveBufferSize = BufferSize;
                ParentServer = server;

                //Starts a read thread.
                ReadThread = new Thread(new ThreadStart(delegate
                {
                    Read(client);
                }));
                ReadThread.Start();
                Server.log("Client read thread started.");

                //Starts a write thread.
                WriteThread = new Thread(new ThreadStart(delegate
                {
                    Write(client);
                }));
                WriteThread.Start();
                Server.log("Client write thread started.");
            }

            /// <summary>
            /// Sends a string message to the client. This message is added to the write queue and send
            /// once it is it's turn. This ensures all messages are send in order they are given.
            /// </summary>
            public void SendMessage(BufferStream buffer)
            {
                WriteQueue.Enqueue(buffer);
            }

            /// <summary>
            /// Disconnects the client from the server and stops all threads for client.
            /// </summary>
            public void DisconnectClient()
            {
                //Console Message.
                Server.log("Disconnecting: " + ClientName);

                //Check if client is ingame.
                if (IsIngame)
                {
                    //Find opposing client.
                    SocketHelper? opponet = null;
                    foreach (SocketHelper lobbyClient in GameLobby.LobbyClients)
                    {
                        if (lobbyClient != this)
                        {
                            opponet = lobbyClient;
                        }
                    }
                    
                    //Causes opponent to win.
                    BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                    buffer.Seek(0);
                    UInt16 constant_out = 1010;
                    buffer.Write(constant_out);
                    opponet.SendMessage(buffer);
                    Server.log(ClientName + " is ingame. Granting win to opponent.");

                    //Remove lobby from server.
                    ParentServer.Lobbies.Remove(GameLobby);
                    GameLobby = null;
                    IsIngame = false;
                }
                
                //Removes client from server.
                ParentServer.Clients.Remove(this);
                if (IsSearching)
                {
                    Server.log(ClientName + " was searching for a game. Stopped searching.");
                    ParentServer.SearchingClients.Remove(this);
                    IsSearching = false;
                }

                //Closes Stream.
                MscClient.Close();

                //Starts an abort thread.
                AbortThread = new Thread(new ThreadStart(delegate
                {
                    Abort();
                }));
                Server.log("Aborting threads on client.");
                AbortThread.Start();
            }

            /// <summary>
            /// Handles aborting of threads.
            /// </summary>
            public void Abort()
            {
                
                //Stops Threads
                ReadThread.Interrupt();
                //Server.log("Read thread aborted on client.");
                WriteThread.Interrupt();
                //Server.log("Write thread aborted on client.");
                Server.log(ClientName + " disconnected.");
                Server.log(Convert.ToString(ParentServer.Clients.Count) + " clients online.");
                AbortThread.Interrupt();
            }

            /// <summary>
            /// Writes data to the client in sequence on the server.
            /// </summary>
            public void Write(TcpClient client)
            {
                while (true)
                {
                    Thread.Sleep(10);
                                     
                    if (WriteQueue.Count != 0)
                    {
                        try
                        {
                            BufferStream buffer = WriteQueue.Dequeue();
                            NetworkStream stream = client.GetStream();
                            stream.Write(buffer.Memory, 0, buffer.Iterator);
                            stream.Flush();
                        }
                        catch (IOException)
                        {
                            DisconnectClient();
                            break;
                        }
                        catch (NullReferenceException)
                        {
                            DisconnectClient();
                            break;
                        }
                        catch (ObjectDisposedException)
                        {
                            break;
                        }
                        catch (InvalidOperationException)
                        {
                            break;
                        }
                    }
                }
            }

            /// <summary>
            /// Reads data from the client and sends back a response.
            /// </summary>
            public void Read(TcpClient client)
            {
                while (true)
                {
                    try
                    {
                        Thread.Sleep(10);
                        BufferStream readBuffer = new BufferStream(BufferSize, 1);
                        NetworkStream stream = client.GetStream();
                        stream.Read(readBuffer.Memory, 0, BufferSize);

                        //Read the header data.
                        ushort constant;
                        readBuffer.Read(out constant);

                        //Determine input commmand.
                        switch (constant)
                        {
                            case 1:
                            {
                                var lobby = new Lobby();
                                String lname = "";
                                readBuffer.Read(out lname);
                                lobby.SetupLobby(lname, this);
                                ParentServer.Lobbies.Add(lobby);
                                Server.log("Created Lobby " + lobby.Name);
                                BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                                buffer.Seek(0);
                                UInt16 constant_out = 1;
                                buffer.Write(constant_out);
                                buffer.Write(GameLobby.Name);
                                SendMessage(buffer);
                                break;
                            }
                            case 2:
                            {
                                //Send Lobby list to client.
                                BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                                buffer.Seek(0);
                                UInt16 constant_out = 2;
                                buffer.Write(constant_out);
                                String LobbyNames = "";
                                foreach (var lobby in ParentServer.Lobbies)
                                {
                                    if (lobby.Name != null)
                                    {
                                        LobbyNames += lobby.Name + ";";
                                    }                                    
                                }
                                buffer.Write(LobbyNames);
                                SendMessage(buffer);
                                Server.log("Sent Lobby list to client");
                                break;
                            }
                            case 4:
                            {
                                String lobby_name;
                                readBuffer.Read(out lobby_name);
                                foreach (var lobby in ParentServer.Lobbies)
                                {
                                    if (lobby.Name.Equals(lobby_name))
                                    {
                                        Server.log(ClientName + " Joined " + lobby_name);
                                        lobby.AddClient(this);
                                    }
                                }
                                break;
                            }
                            case 5:
                            {
                                readBuffer.Read(out UInt16 TalentCard);
                                BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                                buffer.Seek(0);
                                UInt16 constant_out = 5;
                                buffer.Write(constant_out);
                                buffer.Write(TalentCard);
                                Server.log(ClientName + ":" + ClientNumber.ToString() + " set talent to " + TalentCard.ToString());
                                foreach (var other in GameLobby.LobbyClients)
                                {
                                    if (ClientName != other.ClientName)
                                    {
                                        other.SendMessage(buffer);
                                    }
                                }                
                                break;
                            }
                            case 6:
                            {
                                readBuffer.Read(out UInt16 PlayedCard);
                                BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                                buffer.Seek(0);
                                UInt16 constant_out = 6;
                                buffer.Write(constant_out);
                                buffer.Write(PlayedCard);
                                Server.log(ClientName + ":" + ClientNumber.ToString() + " played " + PlayedCard.ToString());
                                foreach (var other in GameLobby.LobbyClients)
                                {
                                    if (ClientName != other.ClientName)
                                    {
                                        other.SendMessage(buffer);
                                    }
                                }                
                                break;
                            }
                            //New Connection
                            case 2000:
                                {
                                    try
                                    {
                                        readBuffer.Read(out string json);
                                        Server.log(json);
                                        playerData = JsonSerializer.Deserialize<PlayerData>(json);
                                        ClientName = playerData.Name;

                                        Server.log(ClientName + " connected.");
                                        Server.log(Convert.ToString(ParentServer.Clients.Count) + " clients online.");
                                    }
                                    catch (Exception)
                                    {
                                        Server.log("Invalid player");
                                    }
                                    break;
                                }

                            //Find Game
                            case 8://FindGame
                                {
                                    IsSearching = true;
                                    IsIngame = false;

                                    //Add client to searching clients.
                                    ParentServer.SearchingClients.Add(this);
                                    Server.log(ClientName + " is searching for a game");
                                    break;
                                }

                            //Cancel Find Game
                            case 2002:
                                {
                                    //Read out client data.
                                    String ip;
                                    readBuffer.Read(out ip);

                                    //Update client information.
                                    IsSearching = false;

                                    //Removes client from searching list.
                                    ParentServer.SearchingClients.Remove(this);
                                    Server.log(ip + " stopped searching.");
                                    break;
                                }

                            
                            //Recive client ping.
                            case 2004:
                                {
                                    //Send ping return to client.
                                    BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                                    buffer.Seek(0);
                                    UInt16 constant_out = 1050;
                                    buffer.Write(constant_out);
                                    SendMessage(buffer);
                                    break;
                                }

                            //Recive server ping.
                            case 2005:
                                {
                                    //Nothing - Ping handled in ping thread.
                                    break;
                                }

                            //Recive matchmaking players request.
                            case 2006:
                                {
                                    //Send players online return to client.
                                    BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                                    buffer.Seek(0);
                                    UInt16 constant_out = 1008;
                                    int players_online = ParentServer.Clients.Count;
                                    buffer.Write(constant_out);
                                    buffer.Write(players_online);
                                    SendMessage(buffer);
                                    break;
                                }

                            // 10 = NextTurn
                            case 10:
                                {
                                    //Send end turn input to clients.
                                    BufferStream buffer = new BufferStream(BufferSize, BufferAlignment);
                                    buffer.Seek(0);
                                    UInt16 constant_out = 10;
                                    buffer.Write(constant_out);
                                    ParentServer.SendToLobby(GameLobby, buffer);
                                    Server.log("Recived end turn from " + ClientName);
                                    break;
                                }
                        }
                    }
                    catch (IOException)
                    {
                        DisconnectClient();
                        break;
                    }
                    catch (NullReferenceException)
                    {
                        DisconnectClient();
                        break;
                    }
                    catch (ObjectDisposedException)
                    {
                        break;
                    }
                    catch (InvalidOperationException)
                    {
                        break;
                    }
                }
            }
        }
}