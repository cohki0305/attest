defmodule SampleAppWeb.Router do
  use SampleAppWeb, :router
  use Attest.RouterHelper

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

  scope "/", SampleAppWeb do
    pipe_through :browser # Use the default browser stack
    attest_for :user_page

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SampleAppWeb do
  #   pipe_through :api
  # end
end
