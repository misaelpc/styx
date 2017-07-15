use Mix.Config

# Configure your database
config :styx, Styx.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "misaelpadawan",
  password: "",
  database: "styx_dev",
  hostname: "localhost",
  pool_size: 10
