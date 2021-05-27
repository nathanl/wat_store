defmodule WatStore.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :price_in_cents, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price_in_cents])
    |> validate_required([:name, :price_in_cents])
  end
end
