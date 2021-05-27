defmodule WatStore.Repo do
  use Ecto.Repo,
    otp_app: :wat_store,
    adapter: Ecto.Adapters.Postgres
end
