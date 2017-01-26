;;; projectile-gitlab.el --- Projectile integration with Gitlab

;; Author: Jason Dufair <jase@dufair.org>
;; URL: https://github.com/nlamirault/emacs-gitlab
;; Version: 0.1.0
;; Keywords: gitlab, projectile

;; Package-Requires: ((projectile "20170106.606") (gitlab "0.8.0"))

;; Copyright (C) 2017 Jason Dufair <jase@dufair.org>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

;;; Commentary:

;; Provides integration between Projectile mode and Gitlab


;;; Code:

(require 'projectile)
(require 'gitlab-projects)
(require 'dash)

(defvar projectile-gitlab-project-cache)
(setq projectile-gitlab-project-cache 'nil)

(defun projectile-gitlab-cache-project-id ()
	"If we don't have the project's id in the gitlab-project-cache, go get it from the API."
	(let ((project-name (projectile-project-name)))
		(or (assoc project-name projectile-gitlab-project-cache)
				(let*
						((possible-projects (gitlab-search-projects project-name))
						 (possible-projects-list (-map 'identity possible-projects))
						 (project (--filter
											 (string= project-name (cdr (assoc 'name it)))
											 possible-projects-list))
						 (project-id (cdr (assoc 'id (car project)))))
          (or (equal nil project-id)
              (setq projectile-gitlab-project-cache
                    (cons (cons project-name project-id) projectile-gitlab-project-cache)))))))

(provide 'projectile-gitlab)
;;; projectile-gitlab.el ends here

