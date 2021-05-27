defmodule WatStore.Products do
  @moduledoc """
  Context for products

  """
  alias WatStore.{Repo, Product, Products.Queries}

  def by_criteria(criteria) do
    Product
    |> Queries.by_criteria(criteria)
    |> Repo.all()
  end

  def create(attrs) when is_map(attrs) do
    Product.changeset(%Product{}, attrs)
    |> Repo.insert()
  end
end
