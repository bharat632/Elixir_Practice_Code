
'''
function clause
'''
# defmodule Playground do

#   def test(x) when x<0 do
#     :negative
#   end

#   def test(0), do: :zero

#   def test(x) when x>0 do
#     :positive
#   end
# end

# IO.puts(Playground.test(0))


'''
lambda clause
'''
# defmodule Playground do
#   test = fn
#     x when is_number(x) and x<0 ->
#       :negative

#     0 ->
#       :zero

#     x when is_number(x) and x>0 ->
#       :positive

#     end
# end


'''
conditionals -> if-else and unless
'''
# defmodule Playground do
#   def max(a,b) do
#     if a>=b, do: a , else: b
#   end

  # def max(a,b) do
  #   unless a>=b, do: b , else: a
  # end

# end

# IO.puts(Playground.max(4,5))


'''
conditionals -> cond block
example 1
'''
# defmodule Playground do
#   def max(a,b) do
#     cond do
#       a > b -> a
#       a == b -> "Both are same"
#       a < b -> b
#     end
#   end
# end

# IO.puts(Playground.max(-9,-5))


'''
conditionals -> using case block for conditionals
Example 1 -
'''
# defmodule Playground do
#   def max(a,b) do
#     case a>=b do
#       true -> IO.puts("#{a} is greater than #{b}")
#       false -> IO.puts("#{b} is greater than #{a}")
#     end
#   end
# end

# Playground.max(5-9,0)

'''
Example 2 -
'''
# defmodule Playground do
#   def max(a,b) do
#     case is_number(a)>is_number(b) do
#       true -> IO.puts("#{a} is greater than #{b}")
#       false -> IO.puts("#{b} is greater than #{a}")
#       _ -> :error
#       end
#   end
# end

# Playground.max("rahul",9)

'''
test-function
'''
# defmodule Playground do
#   def play(a,b) do
#     IO.puts(is_number(a))
#     IO.puts(is_number(b))
#   end
# end

# Playground.play("bharat","rahul")


'''
Private function defining and calling within the same module
'''
# defmodule Playground do
#   defp private_func(a,b), do: a+b

#   def sum(a,b), do: private_func(a,b)
# end

# IO.puts(Playground.sum(2,3))

'''
with clause
'''
# defmodule Playground do

#   defp extract_login(%{"login" => login}), do: {:ok, login}
#   defp extract_login(_), do: {:error, "login Misssing"}
#   defp extract_email(%{"email" => email}), do: {:ok , email}
#   defp extract_email(_), do: {:error, "email missing"}
#   defp extract_password(%{"password" => password}), do: {:ok, password}
#   defp extract_password(_), do: {:error, "password missing"}


#   def extract_user do
#     with {:ok, login} <- extract_login(user),
#          {:ok , email} <- extract_email(user),
#          {:ok , password} <- extract_password(user) do
#          {:ok , %{login: login , email: email, password: password}}
#          end
#   end
# end


'''
Recursion
Example 1 -
'''

# defmodule Playground do
#   def print(0), do: IO.puts(0)
#   def print(n) do
#     print(n-1)
#     IO.puts(n)
#   end
# end

# Playground.print(6)


'''
Example -2 = recursive sum of a list
'''
# defmodule Playground do

#   def sum([]), do: 0

#   def sum([h|t]) do
#     h+ sum(t)
#   end

# end

# l = [1,2,3,4,5,6,7,8,9]
# IO.puts(Playground.sum(l))

'''
Example -3 = fibonacci using case-block
'''
# defmodule Playground do

#   def get_number(n) do

#     case n>=0 do
#       false -> :error
#       true ->
#         case n != 0 and n !=1 do
#           false -> n
#           true -> get_number(n-1) + get_number(n-2)

#         end
#     end
#   end
# end

# IO.puts(Playground.get_number(10))

'''
Example -4 = fibonacci using if-else block
'''
# defmodule Playground do

#   def fibonacci(n) do
#     if n >= 0 do
#       if n != 0 and n != 1 do
#         fibonacci(n-1) + fibonacci(n-2)
#       else
#         n
#       end
#     else
#       :error
#     end
#   end
# end

# IO.puts(Playground.fibonacci(3))


'''
Example 5 = fibonacci using function recursion
'''
# defmodule Playground do

#   def start(n) do
#     start = :os.system_time(:seconds)
#     fib = fibo(n)
#     finish = :os.system_time(:seconds)
#     IO.puts(start)
#     IO.puts(finish)
#     IO.puts(finish - start)
#     IO.puts("fibo = #{fib}")
#   end

#   def fibo(n) when n==0 , do: 0
#   def fibo(n) when n==1 , do: 1
#   def fibo(n) when n<0 , do: :error
#   def fibo(n), do: fibo(n-1) + fibo(n-2)

# end

# Playground.start(30)


'''
Example -6 = Fibonacci using tail-call optimization
'''
# defmodule Playground do

#   def fibo(n) when n<0 , do: :error
#   def fibo(n), do: fibo(n,1,0)
#   def fibo(0,_,result), do: result
#   def fibo(n,next,result), do: fibo(n-1,next+result,next)
# end

# IO.puts(Playground.fibo(20))
'''
explanation =
  fibo(10) = fibo(10,1,0) - from line 225
  fibo(10,1,0) = fibo(10-1,1+0,1) - from line 227
  fibo(9,1,1) = fibo(8,2,1) -line 227
  fibo(8,2,1) = fibo(7,3,2) -line 227
  fibo(7,3,2) = fibo(6,5,3) -line 227
  fibo(6,5,3) = fibo(5,8,5) -line 227
  fibo(5,8,5) = fibo(4,13,8) -line 227
  fibo(4,13,8) = fibo(3,21,13) -line 227
  fibo(3,21,13) = fibo(2,34,21) -line 227
  fibo(2,34,21) = fibo(1,55,34) -line 227
  fibo(1,55,21) = fibo(0,89,55) -line 227
  fibo(0,89,55) = fibo(0,_,55) -line 226
  return result = 55
'''

'''
Example 7 - Book example tail-call recursion
'''
# defmodule Playground do
#   def sum(list) do
#     do_sum(0, list)
#   end

#   defp do_sum(current_value , []) , do: current_value

#   defp do_sum(current_value , [head|tail]) do
#     new_sum = current_value + head
#     do_sum(new_sum, tail)
#   end
# end

# IO.puts(Playground.sum([1,2,3,4,5]))

'''
Example -8 multiply of list member but if list is initially empty return 0
'''
# defmodule Playground do
#   def multi([]), do: IO.puts(0)

#   def multi([head|tail]) do
#     # cond do
#     #   list == [] -> 0
#     #   true -> do_multi(1 , list)
#     # end

#     # if list == [] do
#     #   IO.puts("list is empty")
#     #   0
#     # else
#     #   do_multi(1, list)
#     # end
#     do_multi(1, [head|tail])
#   end

#   # def do_multi(current_value, []), do: current_value

#   def do_multi(current_value , [head|tail]) do
#     new_value = current_value*head
#     do_multi(new_value , tail)
#   end

# end

# IO.puts(Playground.multi([1,2,3,4,5]))
# IO.puts(Playground.multi([]))

'''
Enum - There is no loop in elixir thats why we use Enum.
Enum is used to iterate enumrable datatypes like list , set , map etc
'''
# defmodule Playground do
#   def enum do

#     list = [1,2,3,4,5]
#     acc = 10
#     enum_each = fn x -> IO.puts(x) end
#     Enum.each( list ,enum_each)

#     enum_map = fn x -> x*2 , IO.puts(x) end
#     Enum.map(list , enum_map)

#     enum_filter = fn x -> x*x end
#     Enum.filter(list , enum_filter)

    # enum_reduce = fn x,y -> x+y end
    # Enum.reduce(list , acc , enum_reduce)

    '''
      how Enum.reduce work -
      now x = acc and y = value in list
      x = 10 , y = 1 -> 11
      x = 11 , y = 2 -> 13
      x = 13 , y = 3 -> 16
      x = 14 , y = 4 -> 18
      x = 15 , y = 5 -> 20
    '''

#   end
# end

# Playground.enum()

'''
constraints
Example - 1
'''
# defmodule Playground  do
#   def constraints do
#     list = [1,2,3,4,5]
#     for x <- list , do: IO.puts(x*x)
#   end
# end

# Playground.constraints()

'''
Example -2
'''
# defmodule Playground do
#   def contraints do
#     for x <- ["bharat", "rahul"] , y <- [10,20,30] , into: %{} , do: IO.inspect({x,y})
#   end
# end

# Playground.contraints()

'''
Example -3
'''
# defmodule Playground  do
#   def constriants do
#     for x<- 1..9 , y <- 1..9 , x<y , into: %{} , do: IO.inspect({{x,y},x*y})
#   end
# end

# Playground.constriants()

'''
Abstraction and pipe operator
'''
# defmodule Task_list do
#   def new , do: Generate_list.new()

#   def add_list(tasklist , entry) do
#     Generate_list.add_list(tasklist, entry.date , entry.data)
#   end

#   def get_list(tasklist , date) do
#     Generate_list.get_list(tasklist , date)
#   end
# end

# defmodule Generate_list do
#   def new , do: %{}

#   def add_list(tasklist , key , value) do
#     Map.update(
#       tasklist,
#       key,
#       [value],
#       fn values -> [value | values] end
#     )
#   end

#   def get_list(tasklist , key) do
#     Map.get(tasklist , key, [])
#   end
# end

# entry = %{date: ~D[2022-11-01], data: "Do ur work!"}
# tasklist = Task_list.new() |> Task_list.add_list(entry)
# get_data = tasklist |> Task_list.get_list(entry.date)
# IO.puts(get_data)


'''
struct in elixir
'''
'''
normally we will use variable to capture return value of book_name function and then pass the same
variable to book_detail function to get details of book but by using pipe operator we can simply
pass the return value of first function book_name to book_details easily
'''
# defmodule Playground do
#   def book_name(name), do: name
#   def book_details(price , name ), do: IO.puts("Book name is #{name} and price is #{price}")
# end

# Playground.book_name("Elixir in Action") |> Playground.book_details("$27.71")

'''
Module Attribute in Elixir
'''
# defmodule Playground do
#   @moduledoc """
#   This is a quick example of module attribute
#   """
#   # MyIO == ELixir.IO
#   alias IO, as: MyIO
#   @pi 3.14
#   @half 0.5
#   @doc """
#   This is a print function to print hello
#   """
#   def print , do: MyIO.puts("hello")
#   @doc """
#   This is a print function with an argument
#   """
#   @spec print(number) :: number
#   def print(_n) , do: _n
#   def triangle_area(b,h) , do: @half*b*h
#   def circle_area(r), do: @pi*r*r

# end

# IO.puts(Playground.circle_area(5))
# IO.puts(Playground.triangle_area(5,10))
# IO.puts(Playground.print())

# defmodule Main do
#   # import Maintest
#   alias Bodmas , as: Bd
#   use Use.Macro
#   def summation(a,b), do: Bd.add(a,b)
#   # def use_macro(name), do: print(name)
# end

# # Main.summation(5,6)
# Main.print("Bharat")

'''
Process/Beam Process in Elixir
'''
'''
Example 1 - Failure
'''
defmodule Playground do
  def process , do
    IO.inspect(self())

  end
end

Playground.process()
'''
Generic Server
'''
'''
Example - Starting a server
'''
# defmodule ServerProcess do
#   def start(callback_module) do
#     spawn( fn ->
#       initial_state = callback_module.init()
#       loop(callback_module , initial_state)
#     end)
#   end
# end
