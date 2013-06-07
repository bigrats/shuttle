# Copyright 2013 Square Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

# Contains landing pages appropriate for each of the User roles.

class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :translator_required, only: [:translators, :glossary]
  before_filter :reviewer_required, only: :reviewers

  # Redirects to a specific landing page depending on the current User's role.
  #
  # Routes
  # ------
  #
  # * `GET /`

  def index
    flash_options = {
        flash: {
            alert:   flash[:alert],
            warning: flash[:warning],
            notice:  flash[:notice],
            success: flash[:success]
        }
    }

    return redirect_to(administrators_url, flash_options) if current_user.admin? || current_user.monitor?
    return redirect_to(translators_url, flash_options) if current_user.translator?
    return redirect_to(reviewers_url, flash_options) if current_user.reviewer?
  end

  # Displays a landing page appropriate to translators: They can choose the
  # locale they intend to localize for, then view a list of projects with
  # pending localizations in that locale.
  #
  # Routes
  # ------
  #
  # * `GET /translators`

  def translators
  end

  # Displays a landing page appropriate to reviewers: They can choose the
  # locale they intend to review, then view a list of projects with
  # strings pending review in that locale.
  #
  # Routes
  # ------
  #
  # * `GET /reviewers`

  def reviewers
  end

  # Displays a landing page appropriate to administrators: They can view a list
  # of projects and edit their settings.
  #
  # Routes
  # ------
  #
  # * `GET /administrators`

  def administrators
  end

  # Displays a lnading page appropriate to translators: They can view a list of
  # projects and edit their glossary entries.
  #
  # Routes
  # ------
  #
  # * `GET /glossary`

  def glossary
  end
end