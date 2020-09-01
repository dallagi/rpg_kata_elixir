defmodule RpgKata.ThingTest do
  use ExUnit.Case, async: true
  alias RpgKata.Thing

  describe "new/1" do
    test "creates a thing with the specified health" do
      assert %Thing{health: 123, destroyed: false} = Thing.new(123)
    end
  end

  describe "destroy/1" do
    test "does nothing on destroyed things" do
      destroyed_thing = Thing.destroy(Thing.new(1000))
      assert destroyed_thing == Thing.destroy(destroyed_thing)
    end

    test "sets things as destroyed" do
      destroyed_thing = Thing.destroy(Thing.new(1000))
      assert true == destroyed_thing.destroyed
    end

    test "sets health to zero" do
      destroyed_thing = Thing.destroy(Thing.new(1000))
      assert 0 == destroyed_thing.health
    end
  end
end
