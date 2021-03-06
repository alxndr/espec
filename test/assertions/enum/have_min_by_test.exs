defmodule Enum.HaveMinByTest do

  use ExUnit.Case

  defmodule SomeSpec do
    use ESpec

    let :range, do: (1..3)
    let :func, do: fn(el) -> 10 / el end

    context "Success" do
      it do: expect(range).to have_min_by(func, 3)
      it do: expect(range).to_not have_min_by(func, 1)
    end

    context "Error" do
      it do: expect(range).to_not have_min_by(func, 3)
      it do: expect(range).to have_min_by(func, 1)
    end
  end

  setup_all do
    examples = ESpec.Runner.run_examples(SomeSpec.examples)
    { :ok,
      success: Enum.slice(examples, 0, 1),
      errors: Enum.slice(examples, 2, 3)
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
