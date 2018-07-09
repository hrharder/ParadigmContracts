exports.dataTypes = [
  { 'dataType': "address", 'name': "signer"},
  { 'dataType': "address", 'name': "signer's token"},
  { 'dataType': "uint", 'name': "signer's token count"},
  { 'dataType': "address", 'name': "buyer"},
  { 'dataType': "address", 'name': "buyer's token"},
  { 'dataType': "uint", 'name': "buyer's token count"},
  { 'dataType': "uint", 'name': "tokens to buy"},
  { 'dataType': "signature", 'signatureFields': [0, 1, 2, 3, 4, 5]}
];

/*Issues with the ParadigmBank concept for signedTransfer.
*  a. If you give someone the details of for a signed transfer in plain text it will be vulnerable for manual draining.
*  b. Giving just the vrs the information can be determined from the parameters based on the api.
*  c. Perhaps add the contract address to the signature.
*
* */
