defmodule WatStore.ProductFactory do
  alias WatStore.Products

  def create(attrs) do
    {:ok, user} =
      default_attrs()
      |> Map.merge(attrs)
      |> Products.create()
    user
  end

  def default_attrs do
    %{
      name: Faker.Commerce.product_name(),
      price_in_cents: :random.uniform(99_99)
    }
  end
end
