defmodule Send_receive do
  def send_string do
    send(self() , "String message")
  end

  def send_tuple do
    send(self(), {:tuple , "tuple message"})
  end

  def receive_msg do
    receive do

      {:tuple , msg} -> IO.puts(msg)
      msg -> IO.puts(msg)
    after
      5000 -> IO.puts("no msg found!!!")
    end
  end
end
