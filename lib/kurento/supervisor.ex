defmodule Kurento.Supervisor do
  use Supervisor

  def start_link(state \\ []) do
    Supervisor.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(args) do
    query_server_name = Module.concat(Kurento, QueryServer)
    client_name = Module.concat(Kurento, Client)

    children = [
      %{
        id: Kurento.QueryServer,
        start: {Kurento.QueryServer, :start_link, [[client: client_name, name: query_server_name]]}
      },
      %{
        id: Kurento.Client,
        start: {Kurento.Client, :start_link, [[name: client_name]]}
      },
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
