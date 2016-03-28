module GenericResourcefulActions
  private

  def save_and_respond(message = nil)
    if member_object.save
      successful_creation(message)
    else
      failed_creation
    end
  end

  def update_and_respond(member_params, message = nil)
    if member_object.update(member_params)
      successful_update(message)
    else
      failed_update
    end
  end

  def successful_creation(message = nil)
    message ||= "#{member_object.class} was successfully created."
    canned_success(message)
  end

  def successful_update(message = nil)
    message ||= "#{member_object.class} was successfully updated."
    canned_success(message)
  end

  def canned_success(message)
    flash = { success: message }
    redirect_to(member_object, flash: flash)
  end

  def failed_creation
    render :new
  end

  def failed_update
    render :edit
  end

  def destruction
    flash = { info: "#{member_object.class} was successfully destroyed." }
    redirect_to(member_object, flash: flash)
  end
end
