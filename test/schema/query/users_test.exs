defmodule WatStoreWeb.Schema.Query.UsersTest do
  use WatStoreWeb.ConnCase, async: true
  alias WatStore.UserFactory

  test "lists users' names", %{conn: conn} do
    UserFactory.create(%{name: "Alice"})
    UserFactory.create(%{name: "Bob"})
    UserFactory.create(%{name: "Eve"})

    query = """
    query {
      users {
        name
      }
    }
    """

    response = get(conn, "/graphql", query: query)

    assert json_response(response, 200) == %{
             "data" => %{
               "users" => [
                 %{"name" => "Alice"},
                 %{"name" => "Bob"},
                 %{"name" => "Eve"}
               ]
             }
           }
  end

  test "can filter by admin status", %{conn: conn} do
    UserFactory.create(%{name: "Alice", admin: true})
    UserFactory.create(%{name: "Bob", admin: false})
    UserFactory.create(%{name: "Eve", admin: true})

    query = """
    query($admin: boolean!) {
      users(admin: $admin) {
        name
      }
    }
    """

    response = get(conn, "/graphql", query: query, variables: Jason.encode!(%{"admin" => true}))

    assert json_response(response, 200) == %{
             "data" => %{
               "users" => [
                 %{"name" => "Alice"},
                 %{"name" => "Eve"}
               ]
             }
           }
  end

  test "can filter by name_like", %{conn: conn} do
    UserFactory.create(%{name: "Nathan"})
    UserFactory.create(%{name: "Jonathan"})
    UserFactory.create(%{name: "Josh"})

    query = """
    query($name_like: string!) {
      users(name_like: $name_like) {
        name
      }
    }
    """

    response = get(conn, "/graphql", query: query, variables: %{name_like: "jo"})

    assert json_response(response, 200) == %{
             "data" => %{
               "users" => [
                 %{"name" => "Jonathan"},
                 %{"name" => "Josh"}
               ]
             }
           }

    response = get(conn, "/graphql", query: query, variables: %{name_like: "nat"})

    assert json_response(response, 200) == %{
             "data" => %{
               "users" => [
                 %{"name" => "Nathan"},
                 %{"name" => "Jonathan"}
               ]
             }
           }
  end
end
