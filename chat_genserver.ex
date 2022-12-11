defmodule Chat_Server do
  use GenServer

  #client side
  def start_link do
    GenServer.start_link(__MODULE__ , [] , name: __MODULE__)
  end

  def send_msg(msg) do
    GenServer.cast(__MODULE__ , {:new_msg , msg})
  end

  def get_msgs() do
    GenServer.call(__MODULE__ , :get_msgs)
  end

  #server side
  def init(state) do
    {:ok , state}
  end

  def handle_call(:get_msgs , _from , msgs) do
    {:reply , msgs , msgs}
  end

  def handle_cast({:new_msg , msg} , msgs) do
    {:noreply , [msg | msgs]}
  end


end
