Controller = require('./peteshow-controller')

module.exports =
  'input[type=password]'      : 'password',
  'input[type=text]'          : Controller.randomLetters(8),
  'input[type=email]'         : Controller.randomEmail(),
  'input[type=number]'        : Controller.randomNumber(8),
  'input[type=date]'          : Controller.randomDate(),
  'input[name*=email]'        : Controller.randomEmail(),
  'input[name*=number]'       : Controller.randomNumber(8),
  'input[class*=number]'      : Controller.randomNumber(8),
  'input[class*=decimal]'     : Controller.randomNumber(8),
  'input[name*=phone]'        : Controller.randomPhoneNumber(5),
  'input[name*=first_name]'   : Controller.randomName.firstName(),
  'input[name*=last_name]'    : Controller.randomName.lastName(),
  'input[name*=company]'      : Controller.randomName.companyName(),
  'input[name*=line1]'        : Controller.randomAddress.streetName(),
  'input[name*=street]'       : Controller.randomAddress.streetName(),
  'input[name*=suite]'        : Controller.randomAddress.secondary(),
  'input[name*=line2]'        : Controller.randomAddress.secondary(),
  'input[name*=city]'         : Controller.randomAddress.city(),
  'input[name*=zip]'          : Controller.randomAddress.zipCodeFormat(0),
  'input[name*=postal]'       : Controller.randomAddress.zipCodeFormat(0),
  'input[name*=state]'        : Controller.randomAddress.region(),
  'input[name*=job_title]'    : Controller.randomName.catchPhrase(),
  'input[name*=intent]'       : Controller.randomSentence(),
  'input[name*=income]'       : Controller.randomNumber(4),
  'input[name*=amount]'       : Controller.randomNumber(4),
  'input[name*=branch]'       : '400001',
  'input[name*=routing]'      : '400001',
  'input[name*=card_type_cd]' : '001',
  'input[name*=card_number]'  : '4111111111111111',
  'input[name*=cvv]'          : '123'
