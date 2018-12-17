defmodule Koinonia.Account do
  @moduledoc false
  alias Koinonia.Account.User
  alias Koinonia.Repo

  def build_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
  end

  def create_user(attrs) do
    attrs
    |> build_user()
    |> Repo.insert()
  end
end
