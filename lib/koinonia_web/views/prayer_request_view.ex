defmodule KoinoniaWeb.PrayerRequestView do
  use KoinoniaWeb, :view

  def private_public_text(pr) do
    if pr.is_public do
      "(Public)"
    else
      "(Private)"
    end
  end
end
