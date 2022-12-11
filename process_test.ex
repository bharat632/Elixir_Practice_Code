defmodule ProcessTest do

  def process_send do
    send(self(), {"hello ", 1 })
    send(self(), {"tomorow ", 1})
    send(self(), {"i ma ", 1})
    send(self(), {"going ", 1})
    send(self(), {"to visit ", 1})
    send(self(), {"my office in mumbai location ", 0})
  end

  def process_receive do
    result = receive do
      {msg , num} ->
        # IO.puts(msg)
        IO.puts(num*1)
    after
      5000 -> IO.puts("no more msg found")
    end
    IO.puts(result)
    if result != 0 do
      process_receive()
    end
  end
end
