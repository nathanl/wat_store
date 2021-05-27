defmodule WatStore.Orders.Queries do
  import Ecto.Query

  def by_criteria(query, criteria) when is_map(criteria) do
    by_criteria(query, Enum.to_list(criteria))
  end

  def by_criteria(query, [{:total_in_cents_gte, val} | rest]) do
    query
    |> total_in_cents_gte(val)
    |> by_criteria(rest)
  end

  def by_criteria(query, [{:total_in_cents_lte, val} | rest]) do
    query
    |> total_in_cents_lte(val)
    |> by_criteria(rest)
  end

  def by_criteria(query, [] = _criteria), do: query

  def by_id(query, id) do
    from(
      orders in query,
      where: orders.id == ^id
    )
  end

  defp total_in_cents_gte(query, val) do
    from(
      orders in query,
      where: orders.total_in_cents >= ^val
    )
  end

  defp total_in_cents_lte(query, val) do
    from(
      orders in query,
      where: orders.total_in_cents <= ^val
    )
  end
end
