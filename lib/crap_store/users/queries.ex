defmodule CrapStore.Users.Queries do
  import Ecto.Query

  def by_criteria(query, criteria) when is_map(criteria) do
     by_criteria(query, Enum.to_list(criteria))
  end

  def by_criteria(query, [{:admin, bool} | rest]) do
    query
    |> admin_flag(bool)
    |> by_criteria(rest)
  end

  def by_criteria(query, [{:name_like, val} | rest]) do
    query
    |> name_like(val)
    |> by_criteria(rest)
  end

  def by_criteria(query, [] = _criteria), do: query

  defp name_like(query, val) do
    from(
      users in query,
      where: ilike(users.name, ^"%#{val}%")
    )
  end

  defp admin_flag(query, bool) do
    from(
      users in query,
      where: users.admin == ^bool
    )
  end
end
