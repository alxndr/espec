defmodule ESpec.Assertions.EqSpec do

  use ESpec

  describe "ESpec.Assertions.Eq" do
    context "Success" do
      it do: expect(1+1).to eq(2.0)
      it do: expect(1+1).to_not eq(3)
    end

    xcontext "Errors" do
      it do: expect(1+1).to eq(3.0)
      it do: expect(1+1).to_not eq(2)
    end
  end

  describe "be" do
    context "Success" do
      it do: expect(1+1 == 2).to be true
      it do: expect(1+1 == 1).to_not be true
      it do: expect(1+1 == 1).to be false
      it do: expect(nil).to be nil
      it do: expect(1+1).to be 2
    end

    xcontext "Errors" do
      it do: expect(2+2).to be 5
      it do: expect(1+1 == 1).to_not be false
    end
  end

end
