node(:status) { "success" }
node(:data) {
  @notifications.all.map do |n|
    partial("notifications/notification", object: n, locals:
             {
               is_survey: n.is_a?(Survey)
             }
           )
  end
}
