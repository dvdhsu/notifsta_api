node(:status) { "success" }
node(:data) {
  partial("notifications/notification", object: @notification, locals:
           {
             is_survey: @notification.is_a?(Survey)
           }
         )
}
