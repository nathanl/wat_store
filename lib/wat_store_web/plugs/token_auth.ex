defmodule WatStoreWeb.TokenAuth do
  @moduledoc """
  Authenticate users via a token and set the GraphQL context
  """
  import Plug.Conn
  alias WatStore.{Users, User}

  def init(opts), do: opts

  def call(conn, _opts) do
    with {:header, ["Bearer " <> token]} <- {:header, get_req_header(conn, "authorization")},
         {:user, %User{} = user} <- {:user, Users.get_by_token(token)} do
      Absinthe.Plug.put_options(conn, context: %{current_user: user})
    else
      {:header, _} ->
        reject(
          conn,
          "Missing or invalid API header. Expected `Authorization: Bearer [token value]`"
        )

      {:user, nil} ->
        reject(conn, "API token does not match any user")
    end
  end

  defp reject(conn, message) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:forbidden, Jason.encode!(%{error: message}))
    |> halt
  end
end
