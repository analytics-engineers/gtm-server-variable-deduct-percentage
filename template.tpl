___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Deduct percentage",
  "categories": ["UTILITY"],
  "description": "Deducts the desired percentage from any given number and/or sets the desired decimals. Useful when the input value is for example the revenue incl. tax and you want the revenue excl. tax as output.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "number",
    "displayName": "Input number:",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          "[+-]?([0-9]*[.])?[0-9]+"
        ],
        "errorMessage": "Please enter a valid floating point number."
      },
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "includesPercentage",
    "checkboxText": "Input includes percentage.",
    "simpleValueType": true,
    "help": "Select this if the input includes the percentage you want to deduct. This is useful when the input value is for example the revenue including tax and you want the revenue excluding tax as output."
  },
  {
    "type": "TEXT",
    "name": "percentage",
    "displayName": "Percentage to deduct:",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "PERCENTAGE"
      },
      {
        "type": "NON_EMPTY"
      }
    ],
    "defaultValue": 0
  },
  {
    "type": "TEXT",
    "name": "decimals",
    "displayName": "Output decimals:",
    "simpleValueType": true,
    "defaultValue": 2,
    "valueValidators": [
      {
        "type": "PERCENTAGE"
      },
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const makeNumber = require('makeNumber');
const makeString = require('makeString');
const Math = require('Math');

let percentage = data.includesPercentage ? 100 + makeNumber(data.percentage) : makeNumber(data.percentage);
let number = makeNumber(data.number);
let resultNumber = data.includesPercentage ? (number/percentage)*100 : number-((number/100)*percentage);
let decimals = makeNumber(data.decimals);
let multiplier = Math.pow(10, decimals);
let resultString = makeString(Math.round(resultNumber*multiplier)/multiplier);

if(decimals !== 0) {
  if(resultString.indexOf(".") === -1) {
    resultString += ".";
  }
  for(let i = resultString.substring(resultString.indexOf(".")).length-1; i < decimals; i++) {
    resultString += "0";
  }  
}

return resultString;


___TESTS___

scenarios: []


___NOTES___

Created on 22/02/2022, 16:53:19


