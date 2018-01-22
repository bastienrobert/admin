module ApplicationHelper
  def cp(p, c)
    if current_page?(p)
      "active " + c
    else
      c
    end
  end
  def tracking_url
    return [
      ['Aucun', ''],
      ['La Poste', 'https://www.laposte.fr/particulier/outils/suivre-vos-envois?code=@']
    ]
  end
end
