class StripsController < ApplicationController
  before_filter :get_strips
  caches_action :first, :last, :ids, :thumbs, :index, :show
  
  def first
    show_strip 0
  end
  
  def last
    show_strip @strips.size - 1
  end
  
  alias index first
  
  def show
    strip_name = Strip.strip_name_from_id params[:id]
    if index = @strips.index(strip_name)
      show_strip index
    else
      head :not_found
    end
  end
  
  protected
  
  def get_strips
    @strips ||= Strip.all
  end
  
  def show_strip index
    @strip = @strips[index]
    @strip_id = Strip.id_from_strip_name @strip
    unless index == @strips.size - 1
      @next = @strips[index + 1]
      @next_id = Strip.id_from_strip_name @next
    end
    unless index.zero?
      @previous = @strips[index - 1]
      @previous_id = Strip.id_from_strip_name @previous
    end
    
    render :show
  end
  
  def strip_name_from_id id
    id = id.sub(/\d+/) { '%04d' % $&.to_i }
    "first_haibane_#{id}.gif"
  end
end
