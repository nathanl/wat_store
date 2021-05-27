defmodule WatStore.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :quantity, :integer
    field :shipping_status, :string
    field :total_in_cents, :integer

    belongs_to(:user, WatStore.User)
    belongs_to(:product, WatStore.Product)

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:user_id, :product_id, :quantity, :total_in_cents, :shipping_status])
    |> set_initial_shipping_status()
    |> validate_required([:user_id, :product_id, :quantity, :total_in_cents, :shipping_status])
    |> foreign_key_constraint(:user_id, name: :orders_user_id_fkey)
    |> foreign_key_constraint(:product_id, name: :orders_product_id_fkey)
  end

  defp set_initial_shipping_status(changeset) do
    case Ecto.get_meta(changeset.data, :state) do
      :built ->
        put_change(changeset, :shipping_status, "pending")

      :loaded ->
        changeset
    end
  end
end
