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
end
