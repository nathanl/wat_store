defmodule WatStoreWeb.Plugs.RequireAuth do
  @moduledoc """
  Require authentication to be set
  """
  import Plug.Conn
  alias WatStore.User

  def init(opts), do: opts

  def call(%{assigns: %{current_user: %User{}}} = conn, _opts) do
    conn
  end

  def call(%{assigns: %{current_user: {:error, msg}}} = conn, _opts) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:forbidden, Jason.encode!(%{error: msg}))
    |> halt
  end
end
