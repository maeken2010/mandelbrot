defmodule Mandelbrot do

  def list_cood do
    size = 4
    pixel = 100

    c_list = for x <- 0..pixel-1, y <- 0..pixel-1 do
      a = x * size / pixel - size / 2
      b = y * size / pixel - size / 2
      c = Complex.new(b, a)
      {{x, y}, c}
    end

    for {{x, y}, c} <- c_list, draw?(c), do: {x, y}
  end

  def draw?(c) do
    init_z = Complex.new(0)

    draw_f(c, init_z, 0)
  end

  defp draw_f(_, _, n) when n > 50 do
    false
  end

  defp draw_f(c, z, n) do
    new_z = Complex.add(Complex.pow(z, 2), c)

    if Complex.abs(new_z) > 2 do
      true
    else
      draw_f(c, new_z, n+1)
    end
  end
end


