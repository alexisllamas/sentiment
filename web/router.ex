defmodule Etlicus.Router do
  use Etlicus.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Etlicus do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Etlicus do
    pipe_through :api

    get "/afinn", AfinnController, :index
    get "/afinn/:word", AfinnController, :show

    get "/twitter", TwitterController, :index
    get "/twitter/:url", TwitterController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Etlicus do
  #   pipe_through :api
  # end
end
