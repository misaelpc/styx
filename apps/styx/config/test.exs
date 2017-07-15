use Mix.Config

# Configure your database
config :styx, Styx.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "styx_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
