# Sistema de Transmissão Manual

# Variáveis de Classe
var gear = 0  # Número atual da marcha
var rpm = 0  # Rotações por minuto
var torque = 0  # Torque entregue

# Relações de marcha em um dicionário
var gear_ratios = {  
    1: 4.0,  
    2: 2.5,  
    3: 1.7,  
    4: 1.3,  
    5: 1.0,  
    6: 0.8,  
    7: 0.6  
}

# Função para aumentar a marcha
func increase_gear():
    if gear < 7:
        gear += 1  # Aumenta a marcha
        update_rpm()  # Atualiza RPM e torque
    else:
        print("Já está na marcha máxima!")  # Mensagem de marcha máxima

# Função para diminuir a marcha
func decrease_gear():
    if gear > 0:
        gear -= 1  # Diminui a marcha
        update_rpm()  # Atualiza RPM e torque
    else:
        print("Está na marcha mínima!")  # Mensagem de marcha mínima

# Função para atualizar RPM e torque com base na marcha atual
func update_rpm():
    global rpm, torque
    rpm = calculate_rpm()  # Chama a função de cálculo de RPM
    torque = calculate_torque()  # Chama a função de cálculo de torque
    print("RPM Atual:", rpm, "- Torque Entregue:", torque)  # Exibe os valores atuais

# Função para calcular RPM baseado na marcha
func calculate_rpm():
    return 700 * gear  # Exemplo de cálculo, 700 RPM por marcha

# Função para calcular o torque baseado na marcha
func calculate_torque():
    return gear_ratios[gear] * 100  # Exemplo de cálculo de torque baseado na marcha

# Botões de Aumento e Diminuição de Marcha
# botao_mais.connect(increase_gear)  # Conectar botão de mais a função increase_gear
# botao_menos.connect(decrease_gear)  # Conectar botão de menos a função decrease_gear
