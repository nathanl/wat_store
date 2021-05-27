defmodule WatStore.Users do
  @moduledoc """
  Context for users

  """
  alias WatStore.{Repo, User, Users.Queries}

  def get_by_token(token) do
    User
    |> Queries.by_token(token)
    |> Repo.one()
  end

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
