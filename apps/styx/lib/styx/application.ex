defmodule Styx.Application do
  @moduledoc """
  The Styx Application Service.

  The styx system business domain lives in this application.

  Exposes API to clients such as the `Styx.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Styx.Repo, []),
    ], strategy: :one_for_one, name: Styx.Supervisor)
  end
end
