
(in-package :img-generator)

;; configs

(defparameter *svg-file-directory* #P"svg/")

;; util

(defun save-svg-image (file-name scene)
  (with-open-file (s (merge-pathnames* *svg-file-directory* file-name)
                     :direction :output :if-exists :supersede)
    (stream-out s (funcall scene))))


;; draw to scene

(defun img-1 ()
  (let* ((scene (make-svg-toplevel 'svg-1.1-toplevel :height 40 :width 250)))
    (draw scene (:rect :x 0 :y 0 :height 40 :width 250) :fill "#ff0000")
    (text scene (:x 25 :y 25)
      "Mouse o"
      (tspan (:fill "orange" :font-weight "bold") "circle"))
    (draw scene (:circle :cx 200 :cy 20 :r 10) :fill "#0000ff66")
    scene))

(save-svg-image "test2.svg" #'img-1)


