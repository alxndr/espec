defmodule Enum.HaveAllTest do

  use ExUnit.Case

  defmodule SomeSpec do
    use ESpec

    let :range, do: (1..3)
    let :positive, do: fn(el) -> el > 0 end
    let :negative, do: fn(el) -> el < 0 end
  
    context "Success" do
      it do: expect(range).to have_all(positive)
      it do: expect(range).to_not have_all(negative)
    end

    context "Error" do
      it do: expect(range).to_not have_all(positive)
      it do: expect(range).to have_all(negative)
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
