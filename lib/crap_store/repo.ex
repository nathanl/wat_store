defmodule CrapStore.Repo do
  use Ecto.Repo,
    otp_app: :crap_store,
    adapter: Ecto.Adapters.Postgres
end
