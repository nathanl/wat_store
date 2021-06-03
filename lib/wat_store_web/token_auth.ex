defmodule WatStoreWeb.TokenAuth do
  alias WatStore.{User, Users}

  def user_from_header(%{"Authorization" => "Bearer " <> token}) do
    case Users.get_by_token(token) do
      %User{} = user ->
        {:ok, user}

      nil ->
        {:error, "API token does not match any user"}
    end
  end

  def user_from_header(_) do
    {:error, "Missing or invalid API header. Expected `Authorization: Bearer [token value]`"}
  end
end
