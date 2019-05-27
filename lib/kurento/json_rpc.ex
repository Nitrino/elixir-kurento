defmodule Kurento.JsonRpc do
  @moduledoc """
  Support module for JSON-RPC requests
  """

  @doc """
  Prepare body for JSON-RPC request

  ## Examples

      iex> :rand.seed(:exsplus, {101, 102, 103})
      iex> Kurento.JsonRpc.prepare_request("ping", %{interval: 240000})
      %{id: 83748728562, jsonrpc: "2.0", method: "ping", params: %{interval: 240000}}
  """
  def prepare_request(method_name, params \\ %{}) do
    %{
      id: Enum.random(0..100_000_000_000),
      method: method_name,
      jsonrpc: "2.0",
      params: params
    }
  end

  @doc """
  Prepare body and encode to JSON

  ## Examples

      iex> :rand.seed(:exsplus, {101, 102, 103})
      iex> Kurento.JsonRpc.encode!("ping", %{interval: 240000})
      "{\\"id\\":83748728562,\\"jsonrpc\\":\\"2.0\\",\\"method\\":\\"ping\\",\\"params\\":{\\"interval\\":240000}}"
  """
  def encode!(method_name, params \\ %{}), do: Jason.encode!(prepare_request(method_name, params))
end
