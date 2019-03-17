defmodule War.Battle do
  alias War.Player

  def begin(game) do
    {p1_cards, p2_cards, game} = get_cards(game, 1)
    fight(p1_cards, p2_cards, game)
  end

  def fight(p1_cards, p2_cards, game) do
    p1_card = List.last(p1_cards)
    p2_card = List.last(p2_cards)

    game =
      case resolve(p1_card, p2_card) do
        :war ->
          war(p1_cards, p2_cards, game)

        :player2 ->
          {player, _} = Player.add_cards(game.player2, p1_cards ++ p2_cards)
          %{game | player2: player}

        :player1 ->
          {player, _} = Player.add_cards(game.player1, p2_cards ++ p1_cards)
          %{game | player1: player}
      end

    {:ok, game}
  end

  def resolve(card1, card2) do
    cond do
      card1 == card2 ->
        :war

      card1 < card2 ->
        :player2

      card2 < card1 ->
        :player1
    end
  end

  def war(p1_cards, p2_cards, game) do
    {new_p1_cards, new_p2_cards, game} = get_cards(game, 2)
    {:ok, game} = fight(p1_cards ++ new_p1_cards, p2_cards ++ new_p2_cards, game)
    game
  end

  def get_cards(game, count) do
    {p1, p1_cards} = Player.fetch_cards(game.player1, count)
    {p2, p2_cards} = Player.fetch_cards(game.player2, count)
    {p1_cards, p2_cards, %{game | player1: p1, player2: p2}}
  end
end
