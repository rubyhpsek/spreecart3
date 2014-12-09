Deface::Override.new(:virtual_path => 'spree/shared/_footer',
         # :name => 'remove_footer',
         # :remove => '#footer[data-hook]'
         :name => "footer-left",
                 :replace_contents => "#footer-left") do
 '<div id="footer-left" class="columns alpha eight" data-hook>
    <p><%= t(:powered_by) %> <%= link_to "Keane & Jourzee", "https://bambooshop-2014.herokuapp.com/" %></p>
 </div>'
end
        