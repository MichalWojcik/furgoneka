require 'open-uri'
require 'net/http'
require 'digest'


class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]

  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.all
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    @package = Package.new
    @package_id = params[:package_id] if params[:package_id]
    md5pass = Digest::MD5.hexdigest('testtest')

    params = {:email => 'michalw@vp.pl', :password => md5pass}
    url = URI.parse('http://test.furgonetka.pl/api/login.json')
    data = Net::HTTP.post_form(url, params)

    #params = {'param1' => 'value1', 'param2' => 'value2'}
    #url = URI.parse('http://furgonetka.pl/api/packageDetails.json')
    #data = Net::HTTP.post_form(url, params)
    @result = JSON.parse(data.body)
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:pickup_date, :delivery_date, :status, :receiver_street, :receiver_city)
    end
end
