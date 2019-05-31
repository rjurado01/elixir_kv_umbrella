defmodule CalcServer do
  use GenServer

  def init(init_val) when is_number(init_val) do
    {:ok, init_val}
  end

  def init(_) do
    {:stop, "The value must be an integer!"}
  end

  def handle_cast(operation, state) do
    case operation do
      :sqrt -> {:noreply, :math.sqrt(state)}
      {:multiply, multiplier} -> {:noreply, state * multiplier}
      {:div, number} -> {:noreply, state / number}
      {:add, number} -> {:noreply, state + number}
      _ -> {:stop, "Not implemented", state}
    end
  end

  def handle_call(:result, _, state) do
    {:reply, state, state}
  end

  def terminate(_reason, _state) do
    IO.puts "The server terminated"
  end

  ## CLIENT

  def start_link(init_val) do
    GenServer.start_link(CalcServer, init_val, name: __MODULE__)
  end

  def add(number) do
    GenServer.cast(__MODULE__, {:add, number})
  end

  def sqrt do
    GenServer.cast(__MODULE__, :sqrt)
  end

  def multiply(multiplier) do
    GenServer.cast(__MODULE__, {:multiply, multiplier})
  end

  def div(number) do
    GenServer.cast(__MODULE__, {:div, number})
  end

  def result do
    GenServer.call(__MODULE__, :result)
  end
end
