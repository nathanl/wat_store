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

[
  %{
    name: "Pickle Juicer",
    price_in_cents: 29_95
  },
  %{
    name: "Toast Mittens",
    price_in_cents: 15_00
  },
  %{
    name: "Horse Paint",
    price_in_cents: 40_00
  },
  %{
    name: "Smart Spoon",
    price_in_cents: 89_99
  },
  %{
    name: "Bird Collar",
    price_in_cents: 12_25
  },
  %{
    name: "Toilet Bling",
    price_in_cents: 599_99
  },
  %{
    name: "Cat Softener",
    price_in_cents: 6_85
  },
  %{
    name: "Autogoat",
    price_in_cents: 300_00
  },
  %{
    name: "Taco Cannon",
    price_in_cents: 100_00
  },
  %{
    name: "Mustache Repellent",
    price_in_cents: 35_00
  },
  %{
    name: "Brawn Filters",
    price_in_cents: 12_75
  },
  %{
    name: "Meeting Simulator",
    price_in_cents: 5_999_99
  }
]
|> Enum.each(fn product_map ->
  %WatStore.Product{}
  |> Map.merge(product_map)
  |> WatStore.Repo.insert!()
end)
