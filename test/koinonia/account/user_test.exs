defmodule Koinonia.UserTest do
  use Koinonia.DataCase

  alias Koinonia.Account
  alias Koinonia.Account.User

  test "build_user/0 returns a user changeset" do
    assert %Ecto.Changeset{data: %User{}} = Account.build_user()
  end

  test "build_user/1 returns a user with values applied" do
    attrs = %{"username" => "JohnSmith1"}
    changeset = Account.build_user(attrs)
    assert changeset.params == attrs
  end

  test "create_user/1 returns a user for valid data" do
    valid_attrs = %{
      "username" => "CharlieBrown",
      "email" => "PigPen@Peanuts.com",
      "password" => "Snoopy"
    }

    assert {:ok, user} = Account.create_user(valid_attrs)

    assert Comeonin.Bcrypt.checkpw(valid_attrs["password"], user.password_hash)
  end

  test "create_user/1 returns a changeset for invalid data" do
    invalid_attrs = %{}
    assert {:error, %Ecto.Changeset{}} = Account.create_user(invalid_attrs)
  end
end
