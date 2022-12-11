#current_state = list of entries of struct


defmodule Tasklist do
  defstruct id: 0, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %Tasklist{},
      fn entry, acc -> add_task(acc, entry) end
    )
  end

  def add_task(task_list, entry) do
    entry = Map.put(entry, :id, task_list.id)

    new_entries =
      Map.put(
        task_list.entries,
        task_list.id,
        entry
      )

    %Tasklist{
      task_list
      | entries: new_entries,
        id: task_list.id + 1
    }
  end

  def get_tasks(task_list, date) do
    task_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def get_all(tasklist) do
    tasklist.entries
  end

  def update_task(task_list, %{} = new_entry) do
    update_task(task_list, new_entry.id, fn _ -> new_entry end)
  end

  def update_task(task_list, entry_id, update_fn) do
    case Map.fetch(task_list.entries, entry_id) do
      :error ->
        task_list

      {:ok, old_entry} ->
        new_entry = update_fn.(old_entry)

        new_entries =
          Map.put(
            task_list.entries,
            new_entry.id,
            new_entry
          )

        %Tasklist{task_list | entries: new_entries}
    end
  end
end



defmodule GenericServer do

  def start(module) do
    spawn(fn ->
      init_state = module.init()
      loop(module , init_state)
    end)
  end

  defp loop(module , current_state) do

      receive do
        {:call , request , caller_id} ->
          {response, new_state} = module.handle_call(request, current_state)
          send(caller_id, {:response , response})
          loop(module , new_state)

        {:cast , request} ->
          new_state = module.handle_cast(request , current_state)
          loop(module , new_state)
      end
  end

  def call(server_id , request) do
    send(server_id , {:call , request , self()})
    #send(server_id , {:call , {:get_task , date} , self()})

    receive do
      {:response , response} -> IO.puts(response)
    end
  end

  def cast(server_id , request) do
    send(server_id , {:cast , request})
    #send(server_id , {:cast , {:add_task, new_entry}})
  end

end



defmodule Taskserver do
  use GenServer

  #client
  def start_link() do
    GenServer.start_link(__MODULE__, [] )
  end

  # def start() do
  #   GenericServer.start(Taskserver)
  # end

  def add_task(server_id, new_entry ) do
    GenServer.cast(server_id , {:add_task , new_entry})
  end
  # def add_task(server_id , new_entry) do
  #   GenericServer.cast(server_id , {:add_task , new_entry})
  # end

  def get_task(server_id, date) do
    GenServer.call(server_id , {:get_task, date})
  end
  # def get_task(server_id , date) do
  #   GenericServer.call(server_id , {:get_task, date})
  # end

  def get_all(server_id ) do
    GenServer.call(server_id , :get_all)
  end

  #server
  @impl GenServer
  def init(_) do
    send(self(), :process_init)
    {:ok, TaskList.new()}
  end

  # def init() do
  #   Tasklist.new()
  # end

  @impl GenServer
  def handle_cast({:add_task , new_entry} , tasklist) do
    {:noreply, Tasklist.add_task(tasklist, new_entry)}
  end
  # def handle_cast({:add_task , new_entry} , tasklist) do
  #   Tasklist.add_task(tasklist , new_entry )
  # end

  @impl GenServer
  def handle_call(:get_all , tasklist) do
    {:reply, Tasklist.get_all(tasklist), tasklist}
  end

  @impl GenServer
  def handle_call({:get_task , date}, tasklist) do
    {:reply , Tasklist.get_tasks(tasklist , date), tasklist}
  end
  # def handle_call({:get_task , date}, tasklist) do
  #   {Tasklist.get_tasks(tasklist, date), tasklist}
  # end

  @impl GenServer
  def handle_info(:shutdown, state) do
    Process.exit(self(), :kill)
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(msg, state) do
    IO.inspect("Invalid Message: #{msg}")
    {:noreply, state}
  end

end
