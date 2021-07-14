const Scheme = require('./scheme-model')

/*
  If `scheme_id` does not exist in the database:

  status 404
  {
    "message": "scheme with scheme_id <actual id> not found"
  }
*/
const checkSchemeId = async (req, res, next) => {
  const scheme = await Scheme.checkId(req.params.scheme_id)
  if(!scheme){
    res.status(404).json({
      message: `scheme with scheme_id ${req.params.scheme_id} not found`
    })
  } else {
    next()
  }
}

/*
  If `scheme_name` is missing, empty string or not a string:

  status 400
  {
    "message": "invalid scheme_name"
  }
*/
const validateScheme = (req, res, next) => {
  const { scheme_name } = req.body
  console.log(scheme_name)
  if(!scheme_name || typeof scheme_name !== 'string'){
    res.status(400).json({
      message: 'invalid scheme_name'
    })
  } else {
      next()
  }
}

/*
  If `instructions` is missing, empty string or not a string, or
  if `step_number` is not a number or is smaller than one:

  status 400
  {
    "message": "invalid step"
  }
*/
const validateStep = (req, res, next) => {
  const { instructions, step_number } = req.body
  console.log(step_number, instructions)
  if(!instructions || typeof instructions !== 'string'){
    res.status(400).json({
      message: 'invalid step'
    })
  }
  if(!step_number || isNaN(step_number) || step_number < 1){
    res.status(400).json({
      message: 'invalid step'
    })
  } else {
      next()
  }
}

module.exports = {
  checkSchemeId,
  validateScheme,
  validateStep,
}
