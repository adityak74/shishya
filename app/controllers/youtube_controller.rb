class YoutubeController < ActionController::API
    def scrapeChannel
        Yt.configuration.api_key = ENV['GOOGLE_API_KEY']
        begin
            channel = Yt::Channel.new id: params[:id]
            render json: { status: 200, message: channel.title }
        rescue Exception => e
            render json: { status: 400, message: "invalid channel id" }, status: 400
        end
        
        # channel.title # => "Yt Test"
        # video = Yt::Video.new id: "2zBp_715mJI"
        # comments = []
        # puts "Comments Size:", video.comment_count
        # for commentThread in video.threads.limit 100
        #     commentId = commentThread.id
        #     puts commentId
        #     thread = Yt::CommentThread.new id: commentId
        #     comments.push(thread.top_level_comment.text_display)
        # end
        # render json: { status: 200, videoTitle: video.title, comments: comments }
    end
end
