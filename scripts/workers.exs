defmodule Worker do
  use GenServer
  
  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end
  
  @impl true
  def init(state) do
    Process.send_after(self(), :move, random_interval())
    {:ok, state}
  end
  
  @impl true
  def handle_info(:move, state) do
    %{map: map, width: width, height: height, start_pos: start_pos, end_pos: end_pos} = state
    AStar.search(map, width, height, start_pos, end_pos)

    # IO.puts("Path found")

    Process.send_after(self(), :move, random_interval())
    {:noreply, state}
  end
  
  defp random_interval() do
    850 + :rand.uniform(300)
  end
end


dir = Path.dirname(__ENV__.file)

# Install deps
Mix.install([
  {:rustler, "~> 0.22"},
  {:astar, path: Path.dirname(dir)}
])

## Map configs
map = <<0,0,0,0,0,0,1,0,1,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0>>
width = 5
height = 5
start_pos = {0, 0}
end_pos = {4, 4}
state = %{map: map, width: width, height: height, start_pos: start_pos, end_pos: end_pos}

## Start supervisor
children = [
  {DynamicSupervisor, strategy: :one_for_one, name: AStar.DynamicSupervisor}
]

Supervisor.start_link(children, strategy: :one_for_one)

## Start workers
Enum.each(1..10_000, fn _ -> 
  {:ok, _} = DynamicSupervisor.start_child(AStar.DynamicSupervisor, {Worker, state})
end)

## Run script for 1 min
Process.sleep(60_000)
