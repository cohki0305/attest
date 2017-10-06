defmodule Attest.Config do
  def repo do
    Application.get_env(:attest, :repo)
  end
end
