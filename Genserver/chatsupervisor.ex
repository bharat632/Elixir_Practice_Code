defmodule ChatSupervisor do
  alias Task.Supervisor
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    # children = [
    #   worker(ChatServer , [])
    # ]

    children = [
      %{
        id: ChatServer,
        start: {ChatServer, :start_link , []}
      }
    ]

    supervise(children , strategy: :one_for_one)
    # Supervisor.init(children, strategy: :one_for_one , max_restarts: 2 , max_seconds: 60000)
  end

end
