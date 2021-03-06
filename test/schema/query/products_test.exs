defmodule WatStoreWeb.Schema.Query.ProductsTest do
  use WatStoreWeb.ConnCase, async: true
  alias WatStore.{ProductFactory, UserFactory}

  test "lists Products' names", %{conn: conn} do
    ProductFactory.create(%{name: "Toe Hat"})
    ProductFactory.create(%{name: "Hat Remover"})
    ProductFactory.create(%{name: "Window Bell"})
    user = UserFactory.create(%{})

    query = """
    query {
      products {
        name
      }
    }
    """

    response =
      conn
      |> with_api_token_for(user)
      |> get("/graphql", query: query)

    assert json_response(response, 200) == %{
             "data" => %{
               "products" => [
                 %{"name" => "Toe Hat"},
                 %{"name" => "Hat Remover"},
                 %{"name" => "Window Bell"}
               ]
             }
           }
  end

  test "can filter by name_like", %{conn: conn} do
    ProductFactory.create(%{name: "Toe Hat"})
    ProductFactory.create(%{name: "Hat Remover"})
    ProductFactory.create(%{name: "Window Bell"})
    user = UserFactory.create(%{})

    query = """
    query($name_like: string!) {
      products(name_like: $name_like) {
        name
      }
    }
    """

    response =
      conn
      |> with_api_token_for(user)
      |> get("/graphql", query: query, variables: %{name_like: "Hat"})

    assert json_response(response, 200) == %{
             "data" => %{
               "products" => [
                 %{"name" => "Toe Hat"},
                 %{"name" => "Hat Remover"}
               ]
             }
           }
  end

  test "can filter by price", %{conn: conn} do
    ProductFactory.create(%{price_in_cents: 10})
    ProductFactory.create(%{price_in_cents: 10_00})
    ProductFactory.create(%{price_in_cents: 100_00})
    user = UserFactory.create(%{})

    query = """
    query($price_in_cents_gte: integer!) {
      products(price_in_cents_gte: $price_in_cents_gte) {
        price_in_cents
      }
    }
    """

    response =
      conn
      |> with_api_token_for(user)
      |> get("/graphql", query: query, variables: Jason.encode!(%{price_in_cents_gte: 500}))

    assert json_response(response, 200) == %{
             "data" => %{
               "products" => [
                 %{"price_in_cents" => 10_00},
                 %{"price_in_cents" => 100_00}
               ]
             }
           }
  end
end
