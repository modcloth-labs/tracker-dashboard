class Project < ActiveRecord::Base
  attr_accessible :tracker_id, :enabled, :name, :enabled_labels, :enabled_labels_list, :all_labels

  def enabled_labels_list
    enabled_labels.split(",").map(&:strip)
  end

  def enabled_labels_list= newval
    self.enabled_labels = newval.reject(&:blank?).join(",")
  end

  def all_labels_list
    all_labels.split(",").map(&:strip)
  end
end
