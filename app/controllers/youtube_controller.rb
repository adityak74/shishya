require 'json'

class YoutubeController < ActionController::API
    VIDEO_LIMIT = 10
    COMMENT_LIMIT = 20
    def scrapeChannel
        Yt.configuration.api_key = ENV['GOOGLE_API_KEY']
        begin
            channel = Yt::Channel.new id: params[:id]
            channelData = []
            videos = channel.videos.limit VIDEO_LIMIT
            for video in videos
                video = Yt::Video.new id: video.id
                comments = []
                for commentThread in video.threads.limit COMMENT_LIMIT
                    commentId = commentThread.id
                    thread = Yt::CommentThread.new id: commentId
                    comments.push(thread.top_level_comment.text_display)
                end
                channelData.push({ videoTitle: video.title, videoURL: video.canonical_url, comments: comments })
            end
            render json: { status: 200, channel: channel.title, channelId: channel.id, channelUrl: channel.canonical_url ,channelData: channelData }, status: 200
        rescue Exception => e
            render json: { status: 400, message: "invalid channel id" }, status: 400
        end
    end
    def getChannelId
        url = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=channel&maxResults=10&q=#{params[:searchString]}&key=#{ENV['GOOGLE_API_KEY']}"
        body = HTTP.get(url).body
        render json: { status: 200, search_results: JSON.parse(body) }
    end
end
