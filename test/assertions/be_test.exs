defmodule BeTest do

  use ExUnit.Case

  defmodule SomeSpec do
    use ESpec
    context "Success" do
      it do: expect(2).to be :>, 1
      it do: expect(2).to_not be :>, 3

      it do: expect(1).to be :!=, 2
      it do: expect(1).to_not be :!=, 1

      it do: expect(1).to be :<=, 1
      it do: expect("abcd").to be :=~, ~r/c(d)/
    end

    context "Errors" do
      it do: expect(2).to be :>, 3
      it do: expect(1).to_not be :==, 1.0
    end
  end

  setup_all do
    examples = ESpec.Runner.run_examples(SomeSpec.examples)
    { :ok,
      success: Enum.slice(examples, 0, 5),
      errors: Enum.slice(examples, 6, 7)
    }
  end

  test "Success", context do
    Enum.each(context[:success], fn(ex) ->
      assert(ex.status == :success)
    end)
  end

  test "Errors", context do
    Enum.each(context[:errors], fn(ex) ->
      assert(ex.status == :failure)
    end)
  end

end
