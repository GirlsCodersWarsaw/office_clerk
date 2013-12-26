# encoding : utf-8
class OrdersController < BeautifulController

  before_filter :load_order, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:order] ||= (Order.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:order)
    do_sort_and_paginate(:order)
    
    @q = Order.search(
      params[:q]
    )

    @order_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @order_scope_for_scope = @order_scope.dup
    
    unless params[:scope].blank?
      @order_scope = @order_scope.send(params[:scope])
    end
    
    @orders = @order_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @order_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Order.attribute_names
          @order_scope.to_a.each{ |o|
            csv << Order.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @order_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Order,@order_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @order }
    end
  end

  def new
    @order = Order.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @order }
    end
  end

  def edit
    
  end

  def create
    @order = Order.create(params_for_model)

    respond_to do |format|
      if @order.save
        format.html {
          if params[:mass_inserting] then
            redirect_to orders_path(:mass_inserting => true)
          else
            redirect_to order_path(@order), :flash => { :notice => t(:create_success, :model => "order") }
          end
        }
        format.json { render :json => @order, :status => :created, :location => @order }
      else
        format.html {
          if params[:mass_inserting] then
            redirect_to orders_path(:mass_inserting => true), :flash => { :error => t(:error, "Error") }
          else
            render :action => "new"
          end
        }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @order.update_attributes(params_for_model)
        format.html { redirect_to order_path(@order), :flash => { :notice => t(:update_success, :model => "order") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @orders = []    
    
    Order.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:order)

        @orders = Order.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @orders = Order.find(params[:ids].to_a)
      end

      @orders.each{ |order|
        if not Order.columns_hash[attr_or_method].nil? and
               Order.columns_hash[attr_or_method].type == :boolean then
         order.update_attribute(attr_or_method, boolean(value))
         order.save
        else
          case attr_or_method
          # Set here your own batch processing
          # order.save
          when "destroy" then
            order.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Order
    foreignkey = :order_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_order
    @order = Order.find(params[:id])
  end

  def params_for_model
    params.require(:order).permit(Order.permitted_attributes)
  end
end

