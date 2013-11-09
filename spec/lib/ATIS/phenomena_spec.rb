require "spec_helper"

describe ATIS::Group::Phenomena do

  let(:metar_object) { ATIS::METAR.new(metar) }

  subject { metar_object.phenomena }

  context "phenomena only" do
    let(:metar) { "UAAA 050000Z VRB01MPS 4100 BR RA NSC 04/03 Q1025 88CLRD65 NOSIG" }
    its(:count) { should == 2 }

    context "first" do
      subject { metar_object.phenomena.first }
      its(:qualifier) { should be_nil }
      its(:descriptor) { should be_nil }
      its(:phenomena) { should == "BR" }
    end

    context "second" do
      subject { metar_object.phenomena.second }
      its(:qualifier) { should be_nil }
      its(:descriptor) { should be_nil }
      its(:phenomena) { should == "RA" }
    end

  end

  context "qualifier and phenomena" do
    subject { metar_object.phenomena.first }
    let(:metar) { "UWWW 081930Z 19004MPS 3800 -RA OVC009" }

    its(:qualifier) { should == "-" }
    its(:descriptor) { should be_nil }
    its(:phenomena) { should == "RA" }
  end

  context "qualifier, descriptor, and phenomena" do
    subject { metar_object.phenomena.first }
    let(:metar) { "UWWW 081930Z 19004MPS 3800 +TSRA OVC009" }

    its(:qualifier) { should == "+" }
    its(:descriptor) { should == "TS" }
    its(:phenomena) { should == "RA" }
  end

end