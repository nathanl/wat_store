defmodule WatStore.Products.Queries do
  import Ecto.Query

  def by_criteria(query, criteria) when is_map(criteria) do
     by_criteria(query, Enum.to_list(criteria))
  end

  def by_criteria(query, [{:name_like, val} | rest]) do
    query
    |> name_like(val)
    |> by_criteria(rest)
  end

  def by_criteria(query, [{:price_in_cents_gte, val} | rest]) do
    query
    |> price_in_cents_gte(val)
    |> by_criteria(rest)
  end

  def by_criteria(query, [{:price_in_cents_lte, val} | rest]) do
    query
    |> price_in_cents_lte(val)
    |> by_criteria(rest)
  end

  def by_criteria(query, [] = _criteria), do: query

  defp name_like(query, val) do
    from(
      products in query,
      where: ilike(products.name, ^"%#{val}%")
    )
  end

  defp price_in_cents_gte(query, val) do
    from(
      products in query,
      where: products.price_in_cents >= ^val
    )
  end

  defp price_in_cents_lte(query, val) do
    from(
      products in query,
      where: products.price_in_cents <= ^val
    )
  end
end
