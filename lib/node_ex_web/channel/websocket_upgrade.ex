defmodule NodeExWeb.Channel.WebsocketUpgrade do
  @moduledoc """
  Plug to upgrade request to websocket connection and starting `WebSock` handler.
  """
  @behaviour Plug

  @impl Plug
  def init(handler), do: handler

  @impl Plug
  def call(%Plug.Conn{} = conn, handler) do
    IO.inspect(conn, label: "conn")
    IO.inspect(handler, label: "handler")

    conn
    |> WebSockAdapter.upgrade(handler, %{path_params: conn.path_params}, [])
    |> Plug.Conn.halt()
  end
end
