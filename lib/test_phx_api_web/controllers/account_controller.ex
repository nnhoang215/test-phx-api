defmodule TestPhxApiWeb.AccountController do
  use TestPhxApiWeb, :controller

  alias TestPhxApi.{Accounts, Accounts.Account, Users, Users.User}
  alias TestPhxApi.Accounts.Account
  alias TestPhxApiWeb.{Auth.Guardian, Auth.ErrorResponse}

  action_fallback TestPhxApiWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
          {:ok, token, _claims} <- Guardian.encode_and_sign(account),
          {:ok, %User{} = _user} <- Users.create_user(account, account_params) do 
      conn
      |> put_status(:created)
      |> render(:account_token, %{account: account, token: token})
    end
  end
  
  # overload to catch bad requests
  def create(conn, account_params) do 
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Invalid Request body format"})
    end
  end
  
  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:account_token, %{account: account, token: token})
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
    # render(conn, :show, account: conn.assigns.account) // show the account stored in session
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
