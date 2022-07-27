defmodule RedisCache.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: RedisCache.Worker.start_link(arg)
      # {RedisCache.Worker, arg}
      {Redix, {"redis://localhost:6379", [name: :redis_server]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RedisCache.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
