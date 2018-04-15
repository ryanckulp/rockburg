## How control flows through services

1. Someone clicks an activity button
2. This currently triggers ActivitiesController#new
3. based on the activity type we:
- Call Activity::<activity_type> with the necessary params
- This sets things up and schedules a sidekiq worker in the future
  - e.g. Activity::Practice -schedules> Band::PracticeWorker
  - Band::PracticeWorker calls the service to actually do the work
  - e.g. Band::PracticeWorker calls Band::Practice to make things happen

-- More to come --