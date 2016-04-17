class SessionsController < Devise::SessionsController
  include ActionController::Live

  def streaming_state
    response.headers['Content-Type'] = 'text/event-stream'
    100.times {
      response.stream.write "hello world\n"
    }
    response.stream.close
  end

  def create
    super
  end
end
