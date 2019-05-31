defmodule MathServer do
  def start do
    spawn(&listen/0)
  end

  defp listen do
    receive do
      {:sqrt, caller, arg} -> send(:some_name, {:result, do_sqrt(arg)})
      _ -> IO.puts(:stderr, "Not implemented.")
    end

    listen()
  end

  defp do_sqrt(arg) do
    :math.sqrt(arg)
  end

  def grab_result do
    receive do
      {:result, result} -> result
      after 5000 -> IO.puts :stderr, "Timeout"
    end
  end
end
