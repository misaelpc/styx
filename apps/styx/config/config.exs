use Mix.Config

config :styx, ecto_repos: [Styx.Repo]

import_config "#{Mix.env}.exs"
