# defmodule Main do
#   alias Maintest , as: Mt
#   def calling(name) , do: Mt.print(name)
# end

# Main.calling("raju")

defmodule Main do
  def play do
    sync_fn = fn x ->
      Process.sleep(1000)
      "#{x} return"
    end
    Enum.map(1..5 , &sync_fn.(&1))
  end
end

Main.play()
