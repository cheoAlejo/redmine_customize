require 'issues_helper'

module RedmineCustomize::Patches::IssuesHelperPatch
  extend ActiveSupport::Concern

  def custom_button_new_values(button, issue)
    new_values = {}
    button.new_values.each do |k, v|
      new_values[k] = v if v.present? && issue.safe_attribute?(k)
    end
    button.custom_field_values.each do |v|
      field_name = "custom_field_values_#{v.custom_field_id}"
      new_values[field_name] = v.value if v.value.present?
    end
    new_values
  end
end

unless IssuesHelper.included_modules.include? RedmineCustomize::Patches::IssuesHelperPatch
  IssuesHelper.send :include, RedmineCustomize::Patches::IssuesHelperPatch
end