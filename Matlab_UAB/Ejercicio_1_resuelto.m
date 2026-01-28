%% Borramos todo
clear % del workspace
clc % de la ventana de comandos
close all hidden % cerramos todas la figuras


%% Datos climaticos
% Temperatura:
monthnames = [{'Ene'},{'Feb'},{'Mar'},{'Abr'},{'May'},{'Jun'},{'Jul'},{'Ago'},{'Sep'},{'Oct'},{'Nov'},{'Dic'}];
T0 = [4,5,7,8,12,14,16,16,13,10,7,5]; % temperatura media al nivel del mar
Trate = 8; % grados/km
T = @(alt) T0 - Trate * alt / 1000; % funcion que nos calcula la temperatura a cada altitud

% Precipitacion:
Precip = [175,125,150,100,75,100,100,125,125,175,175,175]; % mm

%% Balance de masas

% Nieve
Snow_accumulation = @(alt) Precip .* (T(alt) < 5); % acumulacion de nieve en mm a cada altitud

% Fusion: 
% se derretirán 5 cm de nieve al mes spor cada grado de temperatura diurna por encima de 0 ºC
% esta funcion no debe "crear nive"!
Snow_melting =  @(alt) max(0, T(alt) + 2.5) * 50; % fusion de nieve en mm a cada altitud

% Balance de masas mensual para una altitud alt
MB = @(alt) Snow_accumulation(alt)-Snow_melting(alt);

%% Preguntas

% Colocando una estación de esquí: ¿cuál es la altitud más baja con 3 o más meses de nieve?
altitud=0;
meses_con_nieve = sum(MB(altitud)>0);
while meses_con_nieve<3
    altitud=altitud+1; % subir un metro de altitud en cada iteracion
    meses_con_nieve = sum(MB(altitud)>0);
end
disp(['A partir de una altitud de ' num2str(altitud) ' tenemos al menos 3 meses con nieve.'])

% Según estos datos, ¿dónde podríamos encontrar un glaciar en Escocia
% hoy en día? Nota: la cumbre más alta de Escocia es Ben Nevis, a
% 1345 m sobre el nivel del mar.

% Balance de masas anual para una altitud de 1345
MB_mensual_Ben_Nevis=MB(1345);
% Calcular la nieve acumulada 
% empezamos en septiembre [9] para minimizar las posibilidades de tener nieve al principio
mm_snow=0;
for month=[9 10 11 12 1 2 3 4 5 6 7 8]
    mm_snow=max(0,mm_snow+MB_mensual_Ben_Nevis(month));
end
MB_anual_Ben_Nevis=mm_snow;
disp(['A 1345 m sobre el nivel del mar (Ben Nevis) tenemos un balance de masas anual de ' num2str(MB_anual_Ben_Nevis) ' mm de nieve:'])
if MB_anual_Ben_Nevis>0
    disp('    En estas condiciones podemos tener un glaciar.')
else
    disp('    En estas condiciones no podemos tener un glaciar.')
end

% La zona de esquí de Glenshee se encuentra entre 650 y 1050 m de
% altitud. ¿Qué impacto tendrían estos escenarios en el negocio para
% 2100? (aumento de la temperatura de 0.5, 1.5, 2.5 y 3.5 por encima de la
% actual)

% Redefinimos nuestras funciones para incluir el aumento de temperatura deltaT:
T = @(alt,deltaT) T0 - Trate * alt / 1000 + deltaT; % funcion que nos calcula la temperatura a cada altitud y deltaT
Snow_accumulation = @(alt,deltaT) Precip .* (T(alt,deltaT) < 5); % acumulacion de nieve en mm a cada altitudSnow_melting =  @(alt) max(0, T(alt) + 2.5) * 50; % fusion de nieve en mm a cada altitu
Snow_melting =  @(alt,deltaT) max(0, T(alt,deltaT) + 2.5) * 50; % fusion de nieve en mm a cada altitud
MB = @(alt,deltaT) Snow_accumulation(alt,deltaT)-Snow_melting(alt,deltaT);
meses_con_nieve = @(alt,deltaT) sum(MB(alt,deltaT)>0);

disp(['Actualmente Glenshee tiene entre ' num2str(meses_con_nieve(650,0))...
    ' y ' num2str(meses_con_nieve(1050,0)) ' meses con nieve.'])
for deltaT=[1.5 2.5 3.5]
    disp(['    - Con un aumento de ' num2str(deltaT)...
        ' grados, tendrá entre ' num2str(meses_con_nieve(650,deltaT))...
        ' y ' num2str(meses_con_nieve(1050,deltaT)) ' meses con nieve.'])
end

%% Ejercicio de modelización glaciar

% ¿Qué distancias al mar y altitudes nos interesa usar?
%     - 11 pulgadas al día equivalen aproximadamente a 100 metros (en horizontal)
%     - la cumbre más alta de Escocia es Ben Nevis, a 1345 m 
%     - la pendiente media es de 15 grados

% distancia al mar cada 100 m
x = 0:100:1345/tan(15*2*pi/360); % m
% elevaciones
y = x.*tan(15*2*pi/360); % m

% Modelizacion Younger Dryas (ΔT=-4 ºC)
deltaT=-4; % cambiar a -6 para LGM

% balances de masas mensuales
MB_matrix=MB(y',deltaT); % hemos transformado los datos de "y" en una columna

% recalcularemos estos espesores cada año
espesor_glaciar_inicial=x.*0; % mm (hemos multiplicado "x" por 0 para que tenga el mismo numero de datos)
espesor_glaciar_final=x.*NaN; % sin definir todavia

% creamos una figura
figure 
hold on

% Empezamos a simular el tiempo
year=0;
while mean(espesor_glaciar_inicial==espesor_glaciar_final)<1
    year=year+1;
    if year>1
        espesor_glaciar_inicial=espesor_glaciar_final;
    end
    mm_snow=espesor_glaciar_inicial;
    for month=[9 10 11 12 1 2 3 4 5 6 7 8]
        mm_snow=max(0,mm_snow+MB_matrix(:,month)'); % funcion de acumulacion (notar que hemos "tumbado" MB_matrix)
    end
    espesor_glaciar_final(1:end-1)=mm_snow(2:end); % flujo glaciar (diseñado para que se mueva una posición)
    espesor_glaciar_final(end)=0; % del punto más alto se escapa toda la nieve

    % dibujamos nuestro glaciar 1-D
    hold off % para borrar lo anterior
    plot(x,y+espesor_glaciar_final/1000,'-b','LineWidth',2) % superficie glaciar
    hold on
    for n=1:numel(x) % etiquetas de espesor de hielo
        if espesor_glaciar_final(n)>0
            text(x(n),y(n),...
                ['  \leftarrow ' num2str(round(espesor_glaciar_final(n)/1000)) ' m'],...
                'Color','b', 'FontSize', 6)
        end
    end
    plot(x,y,'-k','LineWidth',2) % superficia rocosa
    title(['Año ' num2str(year)])
    drawnow
end
legend('Sup. glaciar','Lecho',...
    'Location','southeast')
xlabel('Distancia al mar (m)')
ylabel('Altutud (m)')
grid on
box on

% Altura del frente glaciar
disp(['Frente glaciar: '...
    num2str(round(...
    y(find(espesor_glaciar_final>0,1,'first'))...
    )), ' m s.n.m.'])
