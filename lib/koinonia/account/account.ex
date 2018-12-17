defmodule Koinonia.Account do
  @moduledoc false
  alias Koinonia.Account.User
  # alias Koinonia.Repo

  def build_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
  end
end
