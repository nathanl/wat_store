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

    response =
      conn
      |> with_api_token_for(user)
      |> get("/graphql", query: query)

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
    mutation CreateOrder($product_id: integer!, $quantity: integer!, $totalInCents: integer!) {
      createOrder(productId: $product_id, quantity: $quantity, totalInCents: $totalInCents) {
        totalInCents
        shippingStatus
      }
    }
    """

    variables =
      %{
        product_id: product.id,
        quantity: 2,
        totalInCents: 50_00
      }
      |> Jason.encode!()

    response =
      conn
      |> with_api_token_for(user)
      |> post("/graphql", query: query, variables: variables)

    assert json_response(response, 200) == %{
             "data" => %{
               "createOrder" => %{
                 "shippingStatus" => "pending",
                 "totalInCents" => 50_00
               }
             }
           }
  end

  test "handles errors when creating an order", %{conn: conn} do
    user = UserFactory.create(%{name: "Alice", api_token: "hey"})
    # product = ProductFactory.create(%{name: "Antiantivenom"})

    query = """
    mutation CreateOrder($product_id: integer!, $quantity: integer!, $totalInCents: integer!) {
      createOrder(productId: $product_id, quantity: $quantity, totalInCents: $totalInCents) {
        totalInCents
        shippingStatus
      }
    }
    """

    variables =
      %{
        product_id: 999,
        quantity: 2,
        totalInCents: 50_00
      }
      |> Jason.encode!()

    response =
      conn
      |> with_api_token_for(user)
      |> post("/graphql", query: query, variables: variables)

    response_data = json_response(response, 200)

    assert %{
             "errors" => [
               %{
                 "message" => "Could not create order",
                 "details" => %{"product_id" => ["does not exist"]}
               }
             ]
           } = response_data
  end

  test "can update an order's shipping status", %{conn: conn} do
    user = UserFactory.create(%{name: "Alice", api_token: "hey"})
    product = ProductFactory.create(%{name: "Antiantivenom"})
    order = OrderFactory.create(%{user_id: user.id, product_id: product.id})

    query = """
    mutation SetOrderShippingStatus($orderId: integer!, $shippingStatus: String!) {
      setOrderShippingStatus(orderId: $orderId, shippingStatus: $shippingStatus) {
        shippingStatus
      }
    }
    """

    variables =
      %{
        orderId: order.id,
        shippingStatus: "Fell off truck"
      }
      |> Jason.encode!()

    response =
      conn
      |> with_api_token_for(user)
      |> post("/graphql", query: query, variables: variables)

    assert json_response(response, 200) == %{
             "data" => %{
               "setOrderShippingStatus" => %{
                 "shippingStatus" => "Fell off truck"
               }
             }
           }
  end
end
