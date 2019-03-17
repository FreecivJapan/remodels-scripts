
(in-package :cl-user)
(defpackage img-generator-asd
  (:use :cl :asdf))
(in-package :img-generator-asd)


;; 
(defsystem img-generator
  :name "img-generator"
  :author "i-makinori"
  :version "1"
  :maintainer ""
  :licence "MIT"
  :description "SVG image generator"
  :long-description "SVG image generator"
  :depends-on (:cl-svg :uiop)
  :components
  ((:file "package")
   (:module "chess_color"
    :components
    ((:file "generate")))
   )
  

  )