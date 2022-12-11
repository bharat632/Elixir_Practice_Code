defmodule Chat do
  use Application

  def start(_types , _args) do
    ChatSupervisor.start_link
  end
end
