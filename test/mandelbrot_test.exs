defmodule MandelbrotTest do
  use ExUnit.Case
  doctest Mandelbrot

  test "0" do
    c = Complex.new(0, 0)
    refute Mandelbrot.draw?(c)
  end

  test "-1" do
    c = Complex.new(-1)
    refute Mandelbrot.draw?(c)
  end

  test "-1 + i" do
    c = Complex.new(1, -1)
    assert Mandelbrot.draw?(c)
  end
end
