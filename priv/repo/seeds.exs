# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WatStore.Repo.insert!(%WatStore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

[
  %{
    name: "Dave",
    email: "dave@example.com",
    api_token: "iheartjava",
    admin: false
  },
  %{
    name: "Gustavo",
    email: "gustavo@example.com",
    api_token: "5demayo",
    admin: true
  },
  %{
    name: "Nathan",
    email: "nathan@example.com",
    api_token: "yodawg",
    admin: true
  },
  %{
    name: "Scott",
    email: "scott@example.com",
    api_token: "bbq",
    admin: false
  }
]
|> Enum.each(fn user_map ->
  %WatStore.User{}
  |> Map.merge(user_map)
  |> WatStore.Repo.insert!()
end)
