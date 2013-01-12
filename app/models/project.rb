class Project < ActiveRecord::Base
  attr_accessible :tracker_id, :enabled, :name, :enabled_labels, :enabled_labels_list, :all_labels
  has_many :iterations, :dependent => :delete_all
  has_many :stories, :dependent => :delete_all
  has_many :labelings, :dependent => :delete_all

  def enabled_labels_list
    enabled_labels.split(",").map(&:strip)
  end

  def enabled_labels_list= newval
    self.enabled_labels = newval.reject(&:blank?).join(",")
  end

  def all_labels_list
    all_labels.split(",").map(&:strip)
  end

  def self.fetch!
    Project.where(:enabled => true).each do |proj|
      begin
        proj.fetch!
      rescue
        puts "Unable to fetch project #{proj.id}: #{$!}"
        puts $!.backtrace.join("\n\t")
        raise
      end
    end
  end

  def fetch!
    tracker_proj = Tracker::Project.find(tracker_id)
    iters = tracker_proj.iterations(:current_backlog)
    transaction do
      # kill existing data
      stories.clear
      iterations.clear
      labelings.clear

      # insert new data
      iters.each do |i|
        i.to_iter(self).save!
      end
    end

    iterations.reload
    self
  end
end
