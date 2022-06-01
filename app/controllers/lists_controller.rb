# frozen_string_literal: true

class ListsController < ApplicationController
  include Pageable
  include Searchable
  include Scoped

  scoped :lists

  before_action :set_list, except: %i(index new create mapping)

  def index
    @pagy, @lists = pagy(lists.order(created_at: :desc).search(@search).for_user(@user_filter))
  end

  def show; end

  def new
    @list = @products.present? ? List.of(@products) : lists.new
  end

  def create
    @list.assign_attributes(list_params)
  end

  def edit; end

  def update
    if @list.update(list_params)
      redirect_to [@account, @list].compact, notice: I18n.t('lists.updated', name: @list.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to [@account, :lists].compact, notice: I18n.t('lists.destroyed', name: @list.name)
  end

  def download
    if @list.file.attached?
      redirect_to url_for(@list.file)
    else
      redirect_to [@account, @list].compact, alert: I18n.t('lists.download_unavailable')
    end
  end

  def mapping
    @name = params[:name]
    @first_line = params[:first_line]

    render layout: false
  end

  def history
    @pagy, @history = pagy(@list.audits.reorder(created_at: :desc, id: :desc))
  end

  def appends; end

  def append
    @list.update(list_params)
    redirect_to [:visualize, @account, @list].compact
  end

  def visualize
    @data_source = List.append_data_source
  end

  def create_appended_list
    list = List.append(@list)
    list.save!
    redirect_to [@account, list].compact, notice: t('lists.appends.success')
  end

  private

  def set_list
    @list = lists.find(params[:id])
  end


  def list_params
    l_params = params.require(:list).permit(
      :record_count, :name, :file, :appends, :visualization,
      column_mappings: {}
    )
    parse_json_array(l_params, :appends)
    l_params
  end

  def render_invalid_create_response
    if @list.audience.present?
      render :new, status: :unprocessable_entity
    else
      @first_line = params[:first_line]
      render 'upload_error', status: :unprocessable_entity
    end
  end

  def parse_json_array(attributes, attribute)
    attributes[attribute] = if attributes.try(:[], attribute).blank?
                              []
                            else
                              attributes[attribute] = Oj.load(attributes[attribute])
                            end
  end
end
