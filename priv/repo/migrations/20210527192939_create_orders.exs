defmodule WatStore.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :quantity, :integer
      add :total_in_cents, :integer
      add :shipping_status, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:user_id])
    create index(:orders, [:product_id])
  end
end
