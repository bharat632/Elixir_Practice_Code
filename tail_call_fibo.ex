defmodule TailCallFibo do
  def start(n) do
    start = :os.system_time(:seconds)
    fib = getNumber(n)
    finish = :os.system_time(:seconds)
    diff = finish - start
    IO.puts("Fib is #{fib}")
    IO.puts("took: #{diff}")
  end

  def getNumber(n) when n < 0, do: :error
  def getNumber(n), do: getNumber(n, 1, 0)
  defp getNumber(0, _, result), do: result
  defp getNumber(n, next, result), do: getNumber(n - 1, next + result, next)
end

Playground.start(1000)
