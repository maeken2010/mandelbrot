defmodule Mandelbrot do

  def write_png() do
    opts = [pixel: 480, size: 0.004, center: {-0.8556675420381044, 0.20850513561703377}]
    image = to_image(opts)

    IO.puts(Image.get_concurrency)

    Image.write(image, "hoge.png")
  end

  def to_image(opts \\ []) do
    pixel = Keyword.get(opts, :pixel, 100)

    l = list_cood(opts)

    Enum.reduce(l, Image.new!(pixel, pixel),
      fn {x, y}, img ->
        Image.Draw.point!(img, x, y, color: :white)
      end
    )
  end

  def list_cood(opts \\ []) do
    size = Keyword.get(opts, :size, 4)
    pixel = Keyword.get(opts, :pixel, 100)
    {ca, cb} = Keyword.get(opts, :center, {0, 0})

    c_list = for x <- 0..pixel-1, y <- 0..pixel-1 do
      a = x * size / pixel - size / 2 + ca
      b = y * size / pixel - size / 2 + cb
      c = Complex.new(a, b)
      {{x, y}, c}
    end

    c_list
      |> Enum.map(fn {cood, c} -> Task.async(fn -> draw_or_nil(cood, c) end) end)
      |> Enum.map(fn t -> Task.await(t) end)
      |> Enum.filter(&(&1))
  end

  def draw_or_nil({x, y}, c) do
    if draw?(c), do: {x, y}, else: nil
  end

  def draw?(c) do
    init_z = Complex.new(0)

    draw_f(c, init_z, 0)
  end

  defp draw_f(_, _, n) when n > 1000 do
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

