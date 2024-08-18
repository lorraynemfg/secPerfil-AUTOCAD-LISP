(defun c:secPerfil ()
  ;; Solicita ao usuário a largura, a espessura da cantoneira, o raio do fillet e o ângulo de rotação
  (setq largura (getreal "\nDigite a largura da cantoneira: "))
  (setq espessura (getreal "\nDigite a espessura da cantoneira: "))
  (setq raio (getreal "\nDigite o raio do fillet: "))
  (setq angulo (getreal "\nDigite o angulo de rotacao (em graus): "))
  
  ;; Calcula os pontos da cantoneira com base na largura e espessura fornecidas
  (setq pt1 (list 0 0))
  (setq pt2 (list espessura 0))
  (setq pt3 (list espessura (- largura espessura)))
  (setq pt4 (list largura (- largura espessura)))
  (setq pt5 (list largura largura))
  (setq pt6 (list 0 largura))

  ;; Desenha a cantoneira com linhas separadas
  (command "line" pt1 pt2 "")
  (setq line1 (entlast))
  
  (command "line" pt2 pt3 "")
  (setq line2 (entlast))
  
  (command "line" pt3 pt4 "")
  (setq line3 (entlast))
  
  (command "line" pt4 pt5 "")
  (setq line4 (entlast))
  
  (command "line" pt5 pt6 "")
  (setq line5 (entlast))
  
  (command "line" pt6 pt1 "")
  (setq line6 (entlast))

  ;; Define o raio do fillet
  (command "fillet" "r" raio)
  
  ;; Aplica o fillet entre as linhas desejadas
  (command "fillet" line1 line2)
  (setq arc1 (entlast))
  (command "fillet" line3 line4)
  (setq arc2 (entlast))
  
  ;; Define o raio do fillet para as outras interseções
  (command "fillet" "r" espessura)
  
  ;; Aplica o fillet nos cantos com a espessura
  (command "fillet" line2 line3)
  (setq arc3 (entlast))
  
  ;; Transforma as linhas e arcos em uma polyline usando join
  (command "pedit" line1 "y" "join" arc1 arc2 arc3 line2 line3 line4 line5 line6 "" "")
  (setq all (entlast))

  ;; Rotaciona o desenho com o ângulo especificado
  (command "rotate" all "" pt1 angulo)

  ;; Finaliza o script
  (princ "\nCantoneira desenhada e rotacionada com sucesso!")
  (princ)
)

;; Fim do script
