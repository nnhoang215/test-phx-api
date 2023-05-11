defmodule TestPhxApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :test_phx_api,
  module: TestPhxApiWeb.Auth.Guardian,
  error_handler: TestPhxApiWeb.Auth.GuardianErrorHandler
  
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end