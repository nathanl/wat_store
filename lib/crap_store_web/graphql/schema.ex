defmodule CrapStoreWeb.GraphQL.Schema do
  @moduledoc """
  The GraphQL schema
  """
  use Absinthe.Schema
  alias CrapStore.Users

  query do
    field :users, list_of(:user) do
      arg(:admin, :boolean)
      arg(:name_like, :string)

      resolve(fn _parent_field, field_args, _context ->
        {:ok, Users.by_criteria(field_args)}
      end)
    end
  end

  object :user do
    @desc "The user's name"
    field :name, :string

    @desc "The user's email"
    field :email, :string

    @desc "Whether the user is an admin"
    field :admin, :boolean
  end
end
