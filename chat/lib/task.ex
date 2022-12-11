defmodule Task1 do

  # use Task , restart: :permanent
  # use Task , restart: :temporary
  # use Task , restart: :transient
  use Task

  def start_link(args) do
    IO.puts("Task Process starting...")
    Task.start_link(__MODULE__ , :run , [args])
  end

  def run(args) do
    IO.puts("running task")
    task_id = Process.whereis(Task1)
    IO.puts(task_id)
  end
end
