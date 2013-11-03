require "spec_helper"

describe ATIS::Group::RVR do

  let(:metar_object) { ATIS::METAR.new(metar) }

  subject { metar_object.rvr }

end