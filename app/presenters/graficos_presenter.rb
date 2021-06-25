class GraficosPresenter < SimpleDelegator
  ENERO = 0
  DICIEMBRE = 12

  def initialize
    @meses = (ENERO..DICIEMBRE).map{|mes| (Date.today - mes.month).beginning_of_month}.reverse
  end

  def montos_prestados
    montos = []
    @meses.each do |mes|
      monto_prestado_mes = Pagare.where(created_at: mes...mes.end_of_month)
                                 .map(&:cantidad_solicitada).sum
      montos.push(monto_prestado_mes)
    end
    montos
  end

  def total_abonos
    montos = []
    @meses.each do |mes|
      montos_abonados = Comprobante.where(created_at: mes...mes.end_of_month)
                                 .map(&:monto_pagado).sum
      montos.push(montos_abonados)
    end
    montos
  end

  def clientes_nuevos
    montos = []
    @meses.each do |mes|
      clientes_nuevos = Socio.where(created_at: mes...mes.end_of_month).count
      montos.push(clientes_nuevos)
    end
    montos
  end

  def obtener_meses
    @meses.map{|mes| I18n.t('date.month_names')[mes.month].capitalize}.reverse
  end
end