(ql:quickload :lispbuilder-sdl)


;;;; util

(defmacro sdl-idle-frame-work (&rest idle-body)
  `(sdl:with-init ()
    (sdl:window 300 300)
    (setf (sdl:frame-rate) 30)
    (sdl:update-display)

    (sdl:with-events ()
      (:quit-event () t)
      (:idle ()
       (sdl:clear-display sdl:*black*)
       ,@idle-body
       ;; (print (format nil "~,4F" (sdl:average-fps)))
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



           

(defun select-img ()
  (let* ((num-frame 4)
         (current-frame 0)
         (cell-pixel-length 60)
         (center (truncate (/ cell-pixel-length 2)))
         (satellite 3))
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
                                                       
      (append (calc-selecter 3 (- current-frame) center satellite)
              (calc-selecter 3 (+ current-frame) center satellite)))
     
     (incf current-frame)
     (print current-frame)

     ;;(sdl:draw-filled-circle-* center center (- center 9)
     ;;:color (sdl:color :r 0 :g 0 :b 0))
     )



     ))


(select-img)

                      
