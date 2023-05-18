defmodule TestPhxApiWeb.Router do
  use TestPhxApiWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end
  
  def handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end
  
  pipeline :auth do
    plug TestPhxApiWeb.Auth.Pipeline
    plug TestPhxApiWeb.Auth.SetAccount
  end
  
  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  scope "/api", TestPhxApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
  end
  
  scope "/api", TestPhxApiWeb do
    pipe_through [:api, :auth]
    get "/accounts/by_id/:id", AccountController, :show
    get "/accounts/sign_out", AccountController, :sign_out
    get "/accounts/refresh_session", AccountController, :refresh_session
    post "/accounts/update", AccountController, :update
  end
end
