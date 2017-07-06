$PUBLIC_KEY_CONEKTA = "key_M3cVm2vHFHcGheiLsQAG1sg"
$PRIVATE_KEY_CONEKTA = "key_VBHU53fRueVKhyG8WrNHYg"


Conekta.config do |c|
  c.locale = :es
  c.api_key = $PRIVATE_KEY_CONEKTA
  c.api_version = '2.0.0'
end

