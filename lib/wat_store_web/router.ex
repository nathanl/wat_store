defmodule WatStoreWeb.Router do
  use WatStoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WatStoreWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WatStoreWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", WatStoreWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: WatStoreWeb.Telemetry
    end
  end

  scope "/" do
    pipe_through [:api]

    forward "/graphql", Absinthe.Plug, schema: WatStoreWeb.GraphQL.Schema
  end

  scope "/" do
    # no auth needed to load this page, but actual requests
    # to the 'default_url' will need a token
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      # BogusSchema can't actually do anything
      schema: WatStoreWeb.GraphQL.BogusSchema,
      # advanced interface allows setting a header like
      # `Authorization: Bearer [api token]`
      interface: :advanced,
      default_url: "/graphql"
  end
end
