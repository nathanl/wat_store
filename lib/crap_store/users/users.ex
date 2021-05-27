defmodule CrapStore.Users do
  @moduledoc """
  Context for users

  """
  alias CrapStore.{Repo, User, Users.Queries}

  def by_criteria(criteria) do
    User
    |> Queries.by_criteria(criteria)
    |> Repo.all()
  end

  def create(attrs) when is_map(attrs) do
    User.changeset(%User{}, attrs)
    |> Repo.insert()
  end
end
