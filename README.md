# Astar

## Try workers (10 000 processes)

> elixir scripts/workers.exs

## Benchmarck

> elixir scripts/bench.exs

    Operating System: Linux
    CPU Information: Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
    Number of Available Cores: 8
    Available memory: 1.45 GB
    Elixir 1.12.2
    Erlang 24.0

    Benchmark suite executing with the following configuration:
    warmup: 2 s
    time: 10 s
    memory time: 2 s
    parallel: 1
    inputs: none specified
    Estimated total run time: 14 s

    Benchmarking astar...

    Name            ips        average  deviation         median         99th %
    astar      355.56 K        2.81 μs   ±863.72%        2.20 μs       18.60 μs

    Memory usage statistics:

    Name     Memory usage
    astar           344 B

    **All measurements for memory usage were the same**
