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
      if Conversation.find_by_id([:conversation_id])
        @conversation = Conversation.find_by_from_phone(params["From"])
      else
        @user = User.find_by_phone(params["To"])
        @conversation = @user.conversation.new
        @conversation.phone = params["From"]
        @conversation.save
      end
      @message = @conversation.incoming_message.build(params["Body"])
    else
      @conversation = Conversation.find_by_id([:conversation_id])
      @message = @conversation.outgoing_message.build(params[:message])
    end

    respond_to do |format|
      if @message.save
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
