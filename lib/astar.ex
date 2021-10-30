defmodule AStar do
  use Rustler, otp_app: :astar, crate: "astar"
  
  @type coord :: {non_neg_integer, non_neg_integer}
  @spec search(binary, pos_integer, pos_integer, coord, coord) :: {:ok, [coord]} | {:error, atom}
  def search(_map, _width, _height, _start, _end), do: :erlang.nif_error(:nif_not_loaded)
end
