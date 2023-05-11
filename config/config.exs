# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :test_phx_api,
  ecto_repos: [TestPhxApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :test_phx_api, TestPhxApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: TestPhxApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TestPhxApi.PubSub,
  live_view: [signing_salt: "SDFsJKxA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :test_phx_api, TestPhxApiWeb.Auth.Guardian,
  issuer: "test_phx_api", 
  secret_key: "wSC2A127B3o4oKCKUdJaBbQoRNFWl7CYAbFUBqiCyuJ3U4M0pPyHKTroRWk0PN/w"
  
# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
