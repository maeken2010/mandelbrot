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

  test "draw_or_nil" do
    c = Complex.new(0, 0)
    assert Mandelbrot.draw_or_nil({0, 0}, c) == nil
  end

  test "list" do
    expect_list = [
      {0, 0},
      {0, 1},
      {0, 2},
      {0, 3},
      {0, 4},
      {1, 0},
      {1, 1},
      {1, 2},
      {1, 3},
      {1, 4},
      {2, 0},
      {2, 1},
      {2, 4},
      {3, 0},
      {3, 1},
      {3, 2},
      {3, 3},
      {3, 4},
      {4, 0},
      {4, 1},
      {4, 2},
      {4, 3},
      {4, 4}
    ]
    actual_list = Mandelbrot.list_cood(size: 4, pixel: 5)

    assert MapSet.equal?(MapSet.new(expect_list), MapSet.new(actual_list))
  end
end
