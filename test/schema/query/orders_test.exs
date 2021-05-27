defmodule WatStoreWeb.Schema.Query.OrdersTest do
  use WatStoreWeb.ConnCase, async: true
  alias WatStore.{OrderFactory, ProductFactory, UserFactory}

  test "lists orders' totals", %{conn: conn} do
    user = UserFactory.create(%{name: "Alice"})
    product = ProductFactory.create(%{name: "Antiantivenom"})

    OrderFactory.create(%{user_id: user.id, product_id: product.id, total_in_cents: 10_00})

    OrderFactory.create(%{user_id: user.id, product_id: product.id, total_in_cents: 20_00})

    query = """
    query {
      orders {
        total_in_cents
        shipping_status
      }
    }
    """

    response = get(conn, "/graphql", query: query)

    assert json_response(response, 200) == %{
             "data" => %{
               "orders" => [
                 %{
                   "total_in_cents" => 1000,
                   "shipping_status" => "pending"
                 },
                 %{
                   "total_in_cents" => 2000,
                   "shipping_status" => "pending"
                 }
               ]
             }
           }
  end

  test "can create an order", %{conn: conn} do
    user = UserFactory.create(%{name: "Alice", api_token: "hey"})
    product = ProductFactory.create(%{name: "Antiantivenom"})

    query = """
    mutation CreateOrder($product_id: integer!, quantity: integer!, totalInCents: integer!) {
      createOrder(productId: $product_id, quantity: $quantity, totalInCents: $totalInCents) {
        totalInCents
      }
    }
    """
    variables = %{
      product_id: product.id
    } |> Jason.encode!(


    response = get(conn, "/graphql", query: query)

    assert json_response(response, 200) == %{
             "data" => %{
               "orders" => [
                 %{
                   "total_in_cents" => 1000,
                   "shipping_status" => "pending"
                 },
                 %{
                   "total_in_cents" => 2000,
                   "shipping_status" => "pending"
                 }
               ]
             }
           }
  end

end
