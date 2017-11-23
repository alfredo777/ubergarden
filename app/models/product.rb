require 'wikipedia'

Wikipedia.Configure {
  domain 'es.wikipedia.org'
  path   'w/api.php'
}
class Product < ApplicationRecord
	has_many :category_products_and_products
    has_many :category_products, through: :category_products_and_products
    has_many :image_products
    has_many :productos_a_pedidos
    scope :nombre, lambda { |nombre| where(["nombre LIKE ?", "%#{nombre}%"])}
    scope :nombre_cientifico, lambda { |nombre_cientifico| where(["nombre_cientifico LIKE ?", "%#{nombre_cientifico}%"])}
    scope :pais_de_procedencia, lambda { |pais_de_procedencia| where(["pais_de_procedencia LIKE ?", "%#{pais_de_procedencia}%"])}
    scope :familia, lambda { |familia| where(["familia LIKE ?", "%#{familia}%"])}
    scope :categoria_principal_interna, lambda { |categoria_principal_interna| where(["categoria_principal_interna LIKE ?", "%#{categoria_principal_interna}%"])}
    scope :orden, lambda { |orden| where(["orden LIKE ?", "%#{orden}%"])}
    scope :color1, lambda { |color1| where(["color1 LIKE ?", "%#{color1}%"])}
    scope :color2, lambda { |color2| where(["color2 LIKE ?", "%#{color2}%"])}
    scope :color3, lambda { |color3| where(["color3 LIKE ?", "%#{color3}%"])}
    scope :color4, lambda { |color4| where(["color4 LIKE ?", "%#{color4}%"])}
    scope :color5, lambda { |color5| where(["color5 LIKE ?", "%#{color5}%"])}
    scope :region_climatica, lambda { |region_climatica| where(["region_climatica LIKE ?", "%#{region_climatica}%"])}
    scope :luz, lambda { |luz| where(["luz LIKE ?", "%#{luz}%"])}
    scope :riego, lambda { |riego| where(["riego LIKE ?", "%#{riego}%"])}


    def wikipedia_link
      if self.nombre_cientifico != nil
    	page = Wikipedia.find( "#{self.nombre_cientifico}" )
      if page != nil
    	@url = page.fullurl
      else
      @url = ''
      end
      else
      @url = ''
      end

    end

    def wikipedia_content
      if self.nombre_cientifico != nil
    	page = Wikipedia.find( "#{self.nombre_cientifico}" )
      if page != nil
    	@text = page.text
      puts ">>>>>>>>>>>#{@text}<<<<<<<<<<<<<<"
       if @text == nil 
        @text = 'No se encontro información para este producto...'
       end
      else
      @text = 'No se encontro información para este producto...'
      end
      else
      @text = ''
      end
    end

    def descuento
       if !self.oferta.nil?
       oferta = self.oferta.to_f / 100
       descuento = self.precio.to_f * oferta.to_f
       descuento = descuento.round(2)
       else
        descuento = 0
       end

    end

    def precio_final
       precio_final = self.precio.to_f - descuento.to_f
       precio_final = precio_final.round(2)
    end


end
