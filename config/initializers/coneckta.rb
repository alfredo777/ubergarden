
if Rails.env == 'development'
$PUBLIC_KEY_CONEKTA = "key_M3cVm2vHFHcGheiLsQAG1sg"
$PRIVATE_KEY_CONEKTA = "key_VBHU53fRueVKhyG8WrNHYg"
else
$PUBLIC_KEY_CONEKTA = "key_exdkyZDp1qKhk4xkugHY1Aw"
$PRIVATE_KEY_CONEKTA = "key_MVgA2Xxiuu3mzHWPrJjnbA"
end


Conekta.config do |c|
  c.locale = :es
  c.api_key = $PRIVATE_KEY_CONEKTA
  c.api_version = '2.0.0'
end

