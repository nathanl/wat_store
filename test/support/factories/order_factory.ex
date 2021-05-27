defmodule WatStore.OrderFactory do
  alias WatStore.Orders

  def create(attrs) do
    {:ok, order} =
      default_attrs()
      |> Map.merge(attrs)
      |> Orders.create()

    order
  end

  def default_attrs do
    %{
      quantity: :rand.uniform(2),
      # Not bothering to make this add up - please assume unreasonable
      # discounts and surcharges have been applied :)
      total_in_cents: :rand.uniform(5)
      # also not bothering to build fake users / products here;
      # you have to supply those
    }
  end
end
