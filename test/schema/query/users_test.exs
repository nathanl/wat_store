defmodule CrapStoreWeb.Schema.Query.UsersTest do
  use CrapStoreWeb.ConnCase, async: true
  alias CrapStore.UserFactory

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
    query {
      users(admin: true) {
        name
      }
    }
    """

    response = get(conn, "/graphql", query: query)

    assert json_response(response, 200) == %{
             "data" => %{
               "users" => [
                 %{"name" => "Alice"},
                 %{"name" => "Eve"}
               ]
             }
           }
  end

  test "can filter by name_like status", %{conn: conn} do
    UserFactory.create(%{name: "Nathan"})
    UserFactory.create(%{name: "Jonathan"})
    UserFactory.create(%{name: "Josh"})

    query = """
    query {
      users(name_like: "jo") {
        name
      }
    }
    """

    response = get(conn, "/graphql", query: query)

    assert json_response(response, 200) == %{
             "data" => %{
               "users" => [
                 %{"name" => "Jonathan"},
                 %{"name" => "Josh"}
               ]
             }
           }

    query = """
    query {
      users(name_like: "nat") {
        name
      }
    }
    """

    response = get(conn, "/graphql", query: query)

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
