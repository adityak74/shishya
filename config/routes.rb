Rails.application.routes.draw do
  get "youtube/scrape/channel/:id", to: "youtube#scrapeChannel"
  get "youtube/channel/:searchString", to: "youtube#getChannelId"
end
