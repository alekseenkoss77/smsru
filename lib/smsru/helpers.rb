module Smsru
  module Helpers
    # method change phone for special format
    # needed format is "7XXXXXXXXXX"
    def normalize_phone(phone)
      _number = phone.gsub(/\D/,'')
      if (_number[0] == '7') and (_number.size == 11)
        _number
      elsif _number[0] != '7' and (_number.size == 10)
        '7' + _number
      elsif _number[0] != '7' and (_number.size == 11)
        _number[0]='7'
        _number
      end
    end
  end
end