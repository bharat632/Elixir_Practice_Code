defmodule Agent do
  def start do
    Agent.start_link( fn -> %{} end)
  end

  def put(pid , msg) do
    Agent.update(pid , fn state -> Map.merge(state , %{name: "Bharat"}) end )
  end

  def get(pid) do
    Agent.get(pid , fn state -> state end)
  end
end
