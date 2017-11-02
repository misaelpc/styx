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
      supervisor(ConCache, [[], [name: :l_rfc1]], [id: :l_rfc1]),
      supervisor(ConCache, [[], [name: :l_rfc2]], [id: :l_rfc2]),
      supervisor(ConCache, [[], [name: :l_rfc3]], [id: :l_rfc3]),
      supervisor(ConCache, [[], [name: :l_rfc4]], [id: :l_rfc4]),
      supervisor(ConCache, [[], [name: :l_rfc5]], [id: :l_rfc5])
    ], strategy: :one_for_one, name: Styx.Supervisor)
  end
end
