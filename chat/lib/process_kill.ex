defmodule Process_kill do
  
  def kill_(n) do
    if n==0 do
      nil
    else
      IO.puts(n)
      chat_id = Process.whereis(ChatServer)
      chat_id |> Process.exit(:kill)
      Process.sleep(200)
      kill_(n-1)
    end
  end
  
end
