class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    if params["From"] 
      if Conversation.find_by_from_phone(params["From"])
        @conversation = Conversation.find_by_from_phone(params["From"])
      else
        @user = User.find_by_phone(params["To"])
        @conversation = @user.conversations.build
        @conversation.phone = params["From"]
        @conversation.save
      end
      @message = @conversation.messages.build(content: params["Body"], 
                                              incoming: true)  
    else
      if Conversation.find_by_id(params[:message][:conversation_id])
        @conversation = Conversation.find_by_id(params[:message][:conversation_id])
        @message = @conversation.messages.build(phone: params[:message][:phone],
                                                  content: params[:message][:content], 
                                                  incoming: false) 
      else
        @conversation = current_user.conversations.build(from_phone: params[:message][:phone])
        if @conversation.save
          @message = @conversation.messages.build(phone: params[:message][:phone],
                                                  content: params[:message][:content], 
                                                  incoming: false)         
        else
          redirect_to :back, notice: "Conversation could not be sent"
        end
      end
    end

    respond_to do |format|
      if @message.save
        if Rails.env.production?
          @to = params[:message][:phone]

          @from = current_user.phone
          twilio_sid = "AC80e970a0930e204d8c4ea3efd7350f8d"
          twilio_token = "a295d3c1888b1958fdb26b2c59b25085"

          @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
          
          @twilio_client.account.sms.messages.create(
            :from => "+1"+"#{@from}",
            :to => "+1"+"#{@to}",
            :body => params[:message][:content]
          )
        end
        format.html { redirect_to root_path, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { rediret_to :back, notice: "Message could not be sent" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
