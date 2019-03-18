(ql:quickload :lispbuilder-sdl)


;;;; util

(defmacro sdl-idle-frame-work (&rest idle-body)
  `(sdl:with-init ()
    (sdl:window 300 300)
    (setf (sdl:frame-rate) 30)g
    (sdl:update-display)

    (sdl:with-events ()
      (:quit-event () t)
      (:idle ()
       (sdl:update-display)
       (sdl:clear-display sdl:*black*)
       ,@idle-body
       (sdl:update-display)
       ))))



(setf (symbol-function 'make-point-list) #'list)
(setf (symbol-function 'p1) #'car)
(setf (symbol-function 'p2) #'cadr)
(setf (symbol-function 'p3) #'caddr)

(setf (symbol-function 'make-point) #'list)
(setf (symbol-function 'p-x) #'car)
(setf (symbol-function 'p-y) #'cadr)
        

;;; sine test


(defun sine-test2 ()
  (sdl-idle-frame-work
   (sdl:draw-box-* 10 10 100 200
                   :color sdl:*magenta*)
  ))

(sine-test2)


;;; selecter


(defun calc-selecter (period now radius num-satellite)
  period now
  (let ((center radius))
    ;; [point] ::  [(p1 p2 p3)] :: [[(center P- P+)]] :: [[[(x,y)]]]
    (loop for i from 1 to num-satellite
          collect
             (make-point-list
              (list center center)
              (list (+ center
                       (* radius
                          (sin (- (* (/ i num-satellite) 2 pi)
                                  (* (/ 1 num-satellite 2 2) 2 pi)
                                  ))))
                    (+ center
                       (* radius
                          (cos (- (* (/ i num-satellite) 2 pi)
                                  (* (/ 1 num-satellite 2 2) 2 pi)
                                  )))))
              (list (+ center
                       (* radius
                          (sin (+ (* (/ i num-satellite) 2 pi)
                                  (* (/ 1 num-satellite 2 2) 2 pi)
                                  ))))
                    (+ center
                       (* radius
                          (cos (+ (* (/ i num-satellite) 2 pi)
                                  (* (/ 1 num-satellite 2 2) 2 pi)
                                  ))))))
          
          )))



           

(defun select-img ()
  (let* ((num-frame 4)
         (current-frame 0)
         (cell-pixel-length 60)
         (center (truncate (/ cell-pixel-length 2)))
         (satellite 8))
    num-frame cell-pixel-length satellite
    (sdl-idle-frame-work

     (mapcar
      #'(lambda (three-point)
          (sdl:draw-trigon (sdl:point :x (p-x (p1 three-point))
                                      :y (p-y (p1 three-point)))
                           (sdl:point :x (p-x (p2 three-point))
                                      :y (p-y (p2 three-point)))
                           (sdl:point :x (p-x (p3 three-point))
                                      :y (p-y (p3 three-point)))
                           :color sdl:*white*))
      (calc-selecter 4 1 center satellite))
     )
    (incf current-frame)
    (print current-frame)

    ;;(sdl:draw-filled-circle-* center center (- center 9)
        ;:color (sdl:color :r 0 :g 0 :b 0))
     ))

(select-img)

                      
