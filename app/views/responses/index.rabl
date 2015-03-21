node(:status) { "success" }
node(:data) {
  @responses.all.map do |r|
    partial("responses/response", object: r)
  end
}
