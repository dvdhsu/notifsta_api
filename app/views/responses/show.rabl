node(:status) { "success" }
node(:data) {
  partial("responses/response", object: @response)
}
