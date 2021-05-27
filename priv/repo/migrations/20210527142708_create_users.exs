defmodule CrapStore.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :admin, :boolean, default: false, null: false
      add :api_token, :string

      timestamps()
    end

  end
end
