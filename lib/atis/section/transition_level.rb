class ATIS::Section::TransitionLevel < ATIS::Section::Base

  uses :transition_level

  format :en do
    block :prefix
    text message.transition_level
  end

  format :ru do
    block :prefix
    digit_conversion message.transition_level
  end

end