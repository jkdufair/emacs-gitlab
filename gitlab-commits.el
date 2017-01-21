;;; gitlab-commits.el --- Groups API

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

;; See API doc:
;; https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/commits.md


;;; Code:

(require 's)

(require 'gitlab-http)

;;(gitlab-list-commits 235)
(defun gitlab-list-commits (project-id)
  "Get commits in a project identified by PROJECT-ID."
  (perform-gitlab-request
   "GET"
   (s-concat "projects/"
             (number-to-string project-id)
             "/repository/commits")
   nil
   200))

;;(gitlab-list-commit-comments 120 "9ff46eca12be2723a77035f14f40c3dabf354236")
(defun gitlab-list-commit-comments (project-id sha)
  "Get the comments for a commit with SHA in project PROJECT-ID."
  (perform-gitlab-request
   "GET"
   (s-concat "projects/"
             (number-to-string project-id)
             "/repository/commits/"
             sha
             "/comments")
   nil
   200))

(provide 'gitlab-commits)
;;; gitlab-commits.el ends here
