module ApplicationHelper
  def belongs_to_models(cn)
    model = cn.classify.constantize
    models = model.reflect_on_all_associations(:belongs_to).map { |a| a.name.to_s.tableize }
      return models
  end

  def data
    if signed_in?
      per_page = params[:per_page].blank? ? 30: params[:per_page]
      page = params[:page].blank? ? 1: params[:page]
      cn = ((controller_name == "registrations")? "users": controller_name)
      #TODO: Replace cn.classify.constantize.all by current_user.send("data", cn)
      instance_variable_set("@#{cn}", cn.classify.constantize.all).paginate(:per_page => per_page, :page => page)

      belongs_to_models(cn).each do |cn|
        instance_variable_set("@#{cn}_select", cn.classify.constantize.all)
      end
    end
  end
end
