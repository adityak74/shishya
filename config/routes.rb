Rails.application.routes.draw do
  get "youtube/scrape/channel/:id", to: "youtube#scrapeChannel"
end
