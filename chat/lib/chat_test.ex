defmodule ChatTest do
  use GenServer

  #client
  def start_link do
    GenServer.start_link(__MODULE__ , [], name: __MODULE__)
  end

  def add_task(msg) do
    GenServer.cast(__MODULE__, {:add_task, msg})
  end

  def get_task() do
    GenServer.call(__MODULE__ , :get_task)
  end

  #server
  def init(state) do
    IO.puts("ChatTest has started...")
    {:ok , state}
  end

  def handle_cast({:add_task , msg}, msgs) do
    {:noreply , [msg |msgs]}
  end

  # def handle_call({:add_task , msg},_from , msgs) do
  #   {:noreply , [msg |msgs] , msgs}
  # end

  def handle_call(:get_task , _from , msgs) do
    {:reply , msgs , msgs}
  end
end
