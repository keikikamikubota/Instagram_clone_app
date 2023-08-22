class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  ## 省略

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver  ##追記
      redirect_to contacts_path, notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  ## 省略

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end