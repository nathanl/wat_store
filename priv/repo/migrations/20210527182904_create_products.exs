defmodule WatStore.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price_in_cents, :integer

      timestamps()
    end

  end
end
