defmodule War.Game do
  defstruct player1: nil, player2: nil, rounds: 0, winner: nil

  alias __MODULE__
  alias War.Player

  def init() do
    deck = War.Deck.build()
    {player1_cards, player2_cards} = Enum.split(deck, 26)

    %Game{
      player1: Player.build(player1_cards),
      player2: Player.build(player2_cards)
    }
  end

  def play(game) do
    with {:ok, game} <- check_state(game),
         {:ok, game} <- War.Battle.begin(game) |> IO.inspect() do
      play(game)
    else
      {:game_over, game} -> {:game_over, game.rounds, game.winner}
    end
  end

  def check_state(%{player1: %{hand: hand, discard: discard}} = game)
      when length(hand) + length(discard) == 0,
      do: {:game_over, %{game | winner: :player2}}

  def check_state(%{player2: %{hand: hand, discard: discard}} = game)
      when length(hand) + length(discard) == 0,
      do: {:game_over, %{game | winner: :player1}}

  def check_state(game) do
    {:ok, %{game | rounds: game.rounds + 1}}
  end
end
