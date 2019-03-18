
(in-package :img-generator)

;; configs

(defparameter *application-root* (asdf:system-source-directory :img-generator))
(defparameter *svg-file-directory* (merge-pathnames *system-root* #P"svg/"))


;; util

(setf (symbol-function 'make-point-list) #'list)
(setf (symbol-function 'p1) #'car)
(setf (symbol-function 'p2) #'cadr)
(setf (symbol-function 'p3) #'caddr)

(setf (symbol-function 'make-point) #'list)
(setf (symbol-function 'p-x) #'car)
(setf (symbol-function 'p-y) #'cadr)


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



;; selecter image

(defun calc-selecter (period now radius num-satellite)  
  (let ((center radius)
        (fill-gap-ratio 4)  ;; 2 => 1:1
        )
    (loop for i from 1 to num-satellite
          ;; [point] ::  [(p1 p2 p3)] :: [[(center P- P+)]] :: [[[(x,y)]]]
          collect
             (make-point-list
              (list center center)
              (list (+ center
                       (* radius
                          (sin (* 2 pi
                                  (+ (/ i num-satellite)
                                     (/ -1 num-satellite 2 fill-gap-ratio)
                                     (/ now num-satellite 2 fill-gap-ratio period))))))
                    (+ center
                       (* radius
                          (cos (* 2 pi
                                  (+ (/ i num-satellite)
                                     (/ -1 num-satellite 2 fill-gap-ratio)
                                     (/ now num-satellite 2 fill-gap-ratio period)))))))
              (list (+ center
                       (* radius
                          (sin (* 2 pi
                                  (+ (/ i num-satellite)
                                     (/ 1 num-satellite 2 fill-gap-ratio)
                                     (/ now num-satellite 2 fill-gap-ratio period))))))
                               
                    (+ center
                       (* radius
                          (cos (* 2 pi
                                  (+ (/ i num-satellite)
                                     (/ 1 num-satellite 2 fill-gap-ratio)
                                     (/ now num-satellite 2 fill-gap-ratio period)))))))
              ))))

(defun selecter-img ()
  (let* ((scene (make-svg-toplevel 'svg-1.1-toplevel :height 40 :width 250)))
    (draw scene (:rect :x 0 :y 0 :height 60 :width 240) :fill "#cccccc00")
    (draw scene (:circle :cx 200 :cy 20 :r 10) :fill "#0000ff66")
    (mapcar #'(lambda (points)
                
                )
    
    scene))

(save-svg-image "selecter.svg" #'selecter-img)
