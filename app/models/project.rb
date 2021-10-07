class Project < ApplicationRecord
  enum working_model: { presential: 1, remote: 2 }
end
