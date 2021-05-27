defmodule WatStore.Orders do
  @moduledoc """
  Context for Orders

  """
  alias WatStore.{Repo, Order, Orders.Queries}

  def by_criteria(criteria) do
    Order
    |> Queries.by_criteria(criteria)
    |> Repo.all()
  end

  def create(attrs) when is_map(attrs) do
    Order.changeset(%Order{}, attrs)
    |> Repo.insert()
  end

  def set_shipping_status(%{order_id: id, shipping_status: status} = attrs) do
    %Order{} =
      order =
      Order
      |> Queries.by_id(id)
      |> Repo.one()

    order
    |> Order.changeset(%{shipping_status: status})
    |> Repo.update()
  end
end
