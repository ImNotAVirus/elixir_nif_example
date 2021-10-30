dir = Path.dirname(__ENV__.file)

# Install deps
Mix.install([
  {:benchee, "~> 1.0"},
  {:rustler, "~> 0.22"},
  {:astar, path: Path.dirname(dir)}
])

## Little map configs
bin_map = <<0,0,0,0,0,0,1,0,1,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0>>
start_pos = {0, 0}
end_pos = {4, 4}

## Run benchmark
Benchee.run(
  %{"astar" => fn -> AStar.search(bin_map, 5, 5, start_pos, end_pos) end},
  time: 10,
  memory_time: 2
)
