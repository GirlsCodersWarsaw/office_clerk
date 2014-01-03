require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AddressesController do

  # This should return the minimal set of attributes required to create a valid
  # Address. As you add validations to Address, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for :address }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AddressesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all addresses as @addresses" do
      before = Address.count
      address = Address.create! valid_attributes
      get :index, {}, valid_session
      Address.count.should be before + 1
    end
  end

  describe "GET show" do
    it "assigns the requested address as @address" do
      address = Address.create! valid_attributes
      get :show, {:id => address.to_param}, valid_session
      assigns(:address).should eq(address)
    end
  end

  describe "GET new" do
    it "assigns a new address as @address" do
      get :new, {}, valid_session
      assigns(:address).should be_a_new(Address)
    end
  end

  describe "GET edit" do
    it "assigns the requested address as @address" do
      address = Address.create valid_attributes
      get :edit, {:id => address.to_param}, valid_session
#      assigns(:address).should eq(address)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Address" do
        expect {
          post :create, {:address => valid_attributes}, valid_session
        }.to change(Address, :count).by(1)
      end

      it "assigns a newly created address as @address" do
        post :create, {:address => valid_attributes}, valid_session
        assigns(:address).should be_a(Address)
        assigns(:address).should be_persisted
      end

      it "redirects to the created address" do
        post :create, {:address => valid_attributes}, valid_session
        response.should redirect_to(Address.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved address as @address" do
        # Trigger the behavior that occurs when invalid params are submitted
        Address.any_instance.stub(:save).and_return(false)
        post :create, {:address => {  :first_name => "" }}, valid_session
        assigns(:address).should be_a_new(Address)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Address.any_instance.stub(:save).and_return(false)
        post :create, {:address => {  :first_name => "" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      
      it "assigns the requested address as @address" do
        address = Address.create valid_attributes
        put :update, {:id => address.to_param, :address => valid_attributes}, valid_session
        assigns(:address).should eq(address)
      end

      it "redirects to the address" do
        address = Address.create! valid_attributes
        put :update, {:id => address.to_param, :address => valid_attributes}, valid_session
        response.should redirect_to(address)
      end
    end

    describe "with invalid params" do
      it "assigns the address as @address" do
        address = Address.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Address.any_instance.stub(:save).and_return(false)
        put :update, {:id => address.to_param, :address => {  :first_name => "" }}, valid_session
        assigns(:address).should eq(address)
      end

      it "re-renders the 'edit' template" do
        address = Address.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Address.any_instance.stub(:save).and_return(false)
        put :update, {:id => address.to_param, :address => {  :first_name => "" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys should not work" do
      address = Address.create! valid_attributes
      before = Address.count
      delete :destroy, {:id => address.to_param}, valid_session
      Address.count.should be before
    end

    it "redirects to the addresses list" do
      address = Address.create! valid_attributes
      delete :destroy, {:id => address.to_param}, valid_session
      response.should redirect_to(addresses_url)
    end
  end

end
