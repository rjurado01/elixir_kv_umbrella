defmodule CalcSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_) do
    supervise(
      [ worker(CalcServer, [0]) ],
      strategy: :one_for_one
    )
  end
end
