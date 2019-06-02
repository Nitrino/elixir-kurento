defmodule Kurento.QueryServer do
  use GenServer

  alias Kurento.Client

  def start_link(opts \\ [client: Kurento.Client]) do
    client = Keyword.get(opts, :client)
    state = %{
      client: client,
      queries: %{},
    }

    GenServer.start_link(__MODULE__, state, opts)
  end

  def init(state) do
    {:ok, state}
  end

  def query(pid, method, params) do
    GenServer.call(pid, {:query, {method, params}})
  end

  def handle_call({:query, {method, params}}, from, %{client: client, queries: queries} = state) do
    ref = make_ref() |> :erlang.ref_to_list |> List.to_string

    Client.query(client, self(), ref, method, params)

    queries = Map.put(queries, ref, from)
    state = Map.put(state, :queries, queries)

    {:noreply, state}
  end

  def handle_cast({:response, ref, response}, %{queries: queries} = state) do
    {from, queries} = Map.pop(queries, ref)

    GenServer.reply(from, response)

    state = Map.put(state, :queries, queries)

    {:noreply, state}
  end
end
