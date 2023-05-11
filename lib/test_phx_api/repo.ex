defmodule TestPhxApi.Repo do
  use Ecto.Repo,
    otp_app: :test_phx_api,
    adapter: Ecto.Adapters.Postgres
end
