defmodule WatStoreWeb.GraphQL.Schema do
  @moduledoc """
  The GraphQL schema
  """
  use Absinthe.Schema
  alias WatStore.{Orders, Products, Users}

  query do
    field :users, list_of(:user) do
      arg(:admin, :boolean)
      arg(:name_like, :string)

      resolve(fn _parent_field, field_args, _context ->
        {:ok, Users.by_criteria(field_args)}
      end)
    end

    field :products, list_of(:product) do
      arg(:name_like, :string)
      arg(:price_in_cents_lte, :integer)
      arg(:price_in_cents_gte, :integer)

      resolve(fn _parent_field, field_args, _context ->
        {:ok, Products.by_criteria(field_args)}
      end)
    end

    field :orders, list_of(:order) do
      arg(:total_in_cents_lte, :integer)
      arg(:total_in_cents_gte, :integer)

      resolve(fn _parent_field, field_args, _context ->
        {:ok, Orders.by_criteria(field_args)}
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

  object :product do
    @desc "The product's name"
    field :name, :string

    @desc "The product's price in cents"
    field :price_in_cents, :integer
  end

  object :order do
    @desc "The orders's total in cents"
    field :total_in_cents, :integer

    @desc "The orders's product quantity"
    field :quantity, :integer

    @desc "The orders's shipping status"
    field :shipping_status, :string
  end
end
