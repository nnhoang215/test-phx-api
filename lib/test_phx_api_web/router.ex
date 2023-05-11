defmodule TestPhxApiWeb.Router do
  use TestPhxApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TestPhxApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create
  end
end
