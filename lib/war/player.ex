defmodule War.Player do
  defstruct hand: [], discard: []

  alias __MODULE__

  def build(cards) do
    %Player{hand: cards}
  end

  def fetch_cards(%{hand: hand, discard: discard} = player, count)
      when length(hand) == 0 and length(discard) > 0 do
    player = %{player | hand: Enum.shuffle(player.discard), discard: []}
    fetch_cards(player, count)
  end

  def fetch_cards(player, count) do
    cards = Enum.slice(player.hand, 0, count)
    {%{player | hand: player.hand -- cards}, cards}
  end

  def add_cards(player, cards) do
    {%{player | discard: player.discard ++ cards}, cards}
  end
end
