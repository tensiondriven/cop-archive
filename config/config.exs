# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cop_archive,
  ecto_repos: [CopArchive.Repo]

# Configures the endpoint
config :cop_archive, CopArchiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4XyrDeMWqZxX42utkNnEVd/kDvVoqYgKCf6wCo4VYhTGX53CqqXTQVjYU57S1C0y",
  render_errors: [view: CopArchiveWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CopArchive.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
