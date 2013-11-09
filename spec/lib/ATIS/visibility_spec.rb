require "spec_helper"

describe ATIS::Group::Visibility do
  let(:metar_object) { ATIS::METAR.new(metar) }

  subject { metar_object.visibility.first }

  context "normal" do
    let(:metar) { "UTSA 4500 " }
    its(:visibility) { should == 4500 }
  end
  context "9999" do
    let(:metar) { "UTSA 9999 " }
    it { should be_unlimited }
  end
end