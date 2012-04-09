module PretendersHelper
  def partner_name(couple, pretender)
    return "- Solo -" if couple.pretender_b.nil?
    couple.pretender_a == pretender ? couple.pretender_b.name : couple.pretender_a.name
  end
end
