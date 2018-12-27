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

  def get_user(id), do: Repo.get(User, id)

  def get_user_by_username(username), do: Repo.get_by(User, username: username)

  def get_user_by_credentials(%{"username" => username, "password" => password}) do
    user = get_user_by_username(username)

    if user && Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      user
    else
      :error
    end
  end
end
