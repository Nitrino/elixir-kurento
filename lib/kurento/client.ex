defmodule Kurento.Client do
  use WebSockex
  require Logger

  alias Kurento.JsonRpc

  @url "ws://127.0.0.1:8888/kurento"

  def start_link(opts) do
    name = Keyword.get(opts, :name)
    url = Keyword.get(opts, :url)
    state = %{
      queries: %{},
      socket: name
    }

    WebSockex.start_link(@url, __MODULE__, state, name: name)
  end

  def query(client, pid, ref, method, params) do
    # Logger.info("Sending message: #{method}, params: #{inspect(params)}")
    # message = prepare(ref, method, params) |> JsonRpc.encode!
    WebSockex.cast(client, {:query, {pid, ref, method, params}})

    # WebSockex.send_frame(client, {:text, message})
  end

  def handle_cast({:query, {pid, ref, method, params}}, %{queries: queries} = state) do
    message = prepare(ref, method, params) |> Jason.encode!
    queries = Map.put(queries, ref, {:query, pid, ref})
    state = Map.put(state, :queries, queries)

    {:reply, {:text, message}, state}
  end


  def handle_frame({:text, message}, %{queries: queries} = state) do
    %{"id" => ref, "result" => result} = Jason.decode!(message)
    {{:query, pid, ^ref}, queries} = Map.pop(queries, ref)
    state = Map.put(state, :queries, queries)

    GenServer.cast(pid, {:response, ref, result})
    {:ok, state}
  end

  def handle_connect(_conn, state) do
    Logger.info("Connected!")
    {:ok, state}
  end


  def handle_disconnect(%{reason: {:local, reason}}, state) do
    Logger.info("Local close with reason: #{inspect reason}")
    {:ok, state}
  end

  def handle_disconnect(disconnect_map, state) do
    super(disconnect_map, state)
  end

  defp prepare(id, method, params) do
    %{
      id: id,
      method: method,
      jsonrpc: "2.0",
      params: params
    }
  end
end
