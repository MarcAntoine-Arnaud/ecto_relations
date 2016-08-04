defmodule EctoRelations.Router do
  use EctoRelations.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
  end

  scope "/", EctoRelations do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/files", FileController
    resources "/streams", StreamController
    resources "/essences", EssenceController
  end

  # Other scopes may use custom stacks.
  scope "/api", EctoRelations do
    pipe_through :api
    resources "/files", FileController
    resources "/streams", StreamController
    resources "/essences", EssenceController
  end
end
