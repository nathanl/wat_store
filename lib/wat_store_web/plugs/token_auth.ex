defmodule WatStoreWeb.Plugs.TokenAuth do
  @moduledoc """
  Authenticate users via a token and set the GraphQL context
  """
  import Plug.Conn
  alias WatStoreWeb.TokenAuth

  def init(opts), do: opts

  def call(conn, _opts) do
    with {:header, [header_val]} <- {:header, get_req_header(conn, "authorization")},
         {:user, {:ok, user}} <-
           {:user, TokenAuth.user_from_header(%{"Authorization" => header_val})} do
      conn
      |> Absinthe.Plug.put_options(context: %{current_user: user})
      |> assign(:current_user, user)
    else
      {:header, _} ->
        assign(
          conn,
          :current_user,
          {:error, "Missing API header. Expected `Authorization: Bearer [token value]`"}
        )

      {:user, {:error, msg}} ->
        assign(conn, :current_user, {:error, msg})
    end
  end
end
