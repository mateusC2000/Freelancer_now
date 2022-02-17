json.project do
  json.title @project.title
  json.description @project.description
  json.requirements @project.requirements
  json.maximum_value_per_hour @project.maximum_value_per_hour
  json.end_date @project.end_date
  json.working_model @project.working_model

  json.owner do
    json.project_owner @project.project_owner.email
  end

  json.category do
    json.project_category @project.project_category.category
  end
end
