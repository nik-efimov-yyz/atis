class ATIS::Group::RVR < ATIS::Group::Base
  matches /R(\d{2}[RLC]?)\/([\/V\dUDNPM]*)/
end
