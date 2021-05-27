defmodule CrapStore.UserFactory do
  alias CrapStore.Users

  def create(attrs) do
    {:ok, user} =
      default_attrs()
      |> Map.merge(attrs)
      |> Users.create()
    user
  end

  def default_attrs do
    %{
      name: Faker.Person.first_name(),
      email: Faker.Internet.email(),
      admin: false,
      api_token: Faker.String.base64()
    }
  end
end
