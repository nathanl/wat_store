defmodule WatStoreWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use WatStoreWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import WatStoreWeb.ConnCase

      alias WatStoreWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint WatStoreWeb.Endpoint
    end
  end

  @doc "Adds to the request an api token header for the given user"
  def with_api_token_for(conn, %{api_token: token} = _user) do
    Plug.Conn.put_req_header(
      conn,
      "authorization",
      "Bearer #{token}"
    )
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WatStore.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(WatStore.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
