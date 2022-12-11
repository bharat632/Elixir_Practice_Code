defmodule ChatSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [])
  end

  # def init(_) do
  #   children = [
  #     worker(ChatServer , [])
  #   ]

  #   supervise(children , strategy: :one_for_one)
  # end

  def init(_) do
    '''
    1st way to define children
    '''
    # children = [
    #   worker(ChatServer , [])
    # ]

    '''
    2nd way to define children
    '''
    # SuperVisor.child_spec(ChatServer , id: ChatServer)

    '''
    3rd way to define children
    '''
    children = [
      %{
        id: ChatServer,
        start: {ChatServer, :start_link , []}
      },
      %{
        id: ChatTest,
        start: {ChatTest, :start_link , []}
      },
      # %{
      #   id: Task1,
      #   start: {Task1, :start_link, [20]}
      # }
    ]

    # supervise(children , strategy: :one_for_one)
    Supervisor.init(children, strategy: :rest_for_one , max_restarts: 2 , max_seconds: 60000)
  end

  # def count_child() do
  #   Supervisor.count_children(ChatSupervisor)
  # end

end
