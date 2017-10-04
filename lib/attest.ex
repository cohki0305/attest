defmodule Attest do
  @moduledoc """
  Documentation for Attest.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Attest.hello
      :world

  """
  def hello do
    :world
  end

  def generator_paths() do
    [".", :attest]
  end
end
