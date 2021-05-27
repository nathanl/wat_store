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

  mutation do
    @desc "Create an order"
    field :create_order, type: :order do
      arg(:product_id, non_null(:integer))
      arg(:quantity, non_null(:integer))
      # Pay what you want! :`¯\_(ツ)_/¯`:
      arg(:total_in_cents, non_null(:integer))

      resolve(fn _parent_field, field_args, %{context: %{current_user: %{id: user_id}}} ->
        case WatStore.Orders.create(Map.put(field_args, :user_id, user_id)) do
          {:ok, order} ->
            {:ok, order}

          {:error, changeset} ->
            {
              :error,
              message: "Could not create order", details: error_details(changeset)
            }
        end
      end)
    end

    @desc "Update an order's shipping_status"
    field :set_order_shipping_status, type: :order do
      arg(:order_id, non_null(:integer))
      arg(:shipping_status, non_null(:string))

      resolve(fn _parent_field, field_args, %{context: %{current_user: %{id: user_id}}} ->
        WatStore.Orders.set_shipping_status(Map.put(field_args, :user_id, user_id))
      end)
    end

    def error_details(changeset) do
      changeset
      |> Ecto.Changeset.traverse_errors(fn {msg, _} -> msg end)
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
