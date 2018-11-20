jobs_hash = {
  'reminder' => {
    'class' => 'Reminders::FindTeamsJob',
    'cron'  =>  '0,15,30,45 * * * *',
    'active_job' => true
  }

  'recap' => {
    'class' => 'Rcaps::FindTeamsJob',
    'cron'  =>  '0,15,30,45 * * * *',
    'active_job' => true
  }
}

Sidekiq::Cron::Job.load_from_hash jobs_hash