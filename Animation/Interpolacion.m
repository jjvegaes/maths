function main
    echo on;
    samples = 0:0.001:1;

    function placelabel(pt,str)
        x = pt(1);
        y = pt(2);
        h = line(x,y);
        h.Marker = '*';
        h = text(x,y,str);

        h.HorizontalAlignment = 'center';
        h.VerticalAlignment = 'bottom';
    end

    % funcion bezier_cubic() que calculen curvas cúbicas. 
    function curve = bezier_cubic(pt1, pt2, pt3, pt4, samples)

        % convierte a row vector
        if (size(samples, 1) ~= 1)
           samples = reshape(samples,[1, length(samples)]); 
        end

        % convirte los puntos a vectores de columna
        if (size(pt1, 2) ~= 1)
           pt1 = pt1.';
        end
        if (size(pt2, 2) ~= 1)
           pt2 = pt2.'; 
        end
        if (size(pt3, 2) ~= 1)
           pt3 = pt3.';
        end
        if (size(pt4, 2) ~= 1)
           pt4 = pt4.'; 
        end

        P = @(t) (1-t).^3.*pt1+3*t.*(1-t).^2.*pt2+3*t.^2.*(1-t).*pt3+t.^3.*pt4;
        % curve = zeros(2, length(samples));
        % for index = 1:length(samples)
        %     curve(:, index) = P(samples(index));
        % end
        curve = P(samples);
    end

    % Ejercicio 1.2.1 – Entrega el 8 de Octubre 2018, 23:59
    % funccion que establecer la correspondencia entre el parámetro y la longitud del arco
    function arc_lengths = compute_arc_length_correspondences(pt1, pt2, pt3, pt4, samples)
        arc_length = 0;
        curve = bezier_cubic(pt1, pt2, pt3, pt4, samples);
        arc_lengths = zeros(1, length(samples));
        arc_lengths(1) = 0;
        for index = 1:length(curve) - 1
            arc_length = arc_length + norm(curve(:, index + 1) - curve(:, index));
            arc_lengths(index + 1) = arc_length;
        end
    end
    % Escribe una funcion en MATLAB llamada 
    % compute_arc_length_cubic_bezier(pt1, pt2, pt3, pt4, samples) 
    % que calcule mediante Forward Differencing la longitud del arco 
    % de una curva cúbica de Bezier. 
    % ¿Cómo cambia el resultado en función del parámetro samples? 
    function longitud = compute_length_cubic_bezier(pt1, pt2, pt3, pt4, samples)
        arcs = compute_arc_length_correspondences(pt1, pt2, pt3, pt4, samples);
        longitud = arcs(length(arcs));
    end

    disp(compute_length_cubic_bezier([1; 2], [3; 3], [6; 9], [5; 30], samples));

    % Ejercicio 1.2.2 – Entrega el 8 de Octubre 2018, 23:59
    % Escribe una función en MATLAB que dados 4 puntos de control, 
    % calcule su curva de Bezier y marque sobre ella: 
    % puntos equidistantes con respecto el parámetro t (tiempo) 
    % y con respecto el parámetro s (longitud del arco). 
    % El resultado final debería ser parecido a esto.
    function plot_equidistante_points_bezier(pt1, pt2, pt3, pt4, samples)
        curve = bezier_cubic(pt1, pt2, pt3, pt4, samples);
        figure;
        grid on;
        hold on;
        xlim([-15, 60]);
        ylim([-20, 50]);
        axis equal;
        
        % esbozar la curva
        plot(curve(1,:), curve(2,:));

        % mostrar 4 puntos
        placelabel(pt1,'  pt_1');
        placelabel(pt2,'  pt_2');
        placelabel(pt3,'  pt_3');
        placelabel(pt4,'  pt_4');
        scatter(pt1(1), pt1(2), 'b', '*');
        scatter(pt2(1), pt2(2), 'b', '*');
        scatter(pt3(1), pt3(2), 'b', '*');
        scatter(pt4(1), pt4(2), 'b', '*');

        % puntos equidistantes con respecto el parámetro t (tiempo) 
        equidistant_t = linspace(0, 1, 30);
        equidistant_points_respect_to_t = bezier_cubic(pt1, pt2, pt3, pt4, equidistant_t);
        scatter(equidistant_points_respect_to_t(1, :), equidistant_points_respect_to_t(2, :), 'r');

        % puntos equidistantes con respecto el parámetro s (longitud del arco)
        arc_lengths = compute_arc_length_correspondences(pt1, pt2, pt3, pt4, samples);
        total_length = arc_lengths(end);
        for i = 1:30
           next_arc_length = i * (total_length / 30);
           [c, index] = min(abs(arc_lengths - next_arc_length));
           scatter(curve(1, index), curve(2, index), 'b');
        end

        hold off;
    end

    plot_equidistante_points_bezier([5; -10], [9; 38], [38; -5], [45; 15], samples);
    
    % Ejercicio 1.2.3 – Entrega el 8 de Octubre 2018, 23:59
    % Dibuja en MATLAB un curva cerrada con continuidad C1 
    % creada por 4 curvas cúbicas de Bezier. 
    % Utiliza transformaciones del tipo translación y escalado 
    % en los puntos de control para cambiar el tamaño la curva dibujada. 
    % Aquí tienes un ejemplo del tipo de resultado que puedes conseguir.
    function plot_4_curve(pt1, pt2, pt3, pt4,...
                          pt5, pt6, pt7, ...
                          pt8, pt9, pt10,...
                          pt11,pt12,...
                          samples, scale, translation)
        figure;
        grid on;
        hold on;
        
        xlim([0, 50]);
        ylim([0, 20]);
        axis equal;
        
        % mostrar 4 puntos 1-4
        placelabel(pt1,'  pt_1');
        placelabel(pt2,'  pt_2');
        placelabel(pt3,'  pt_3');
        placelabel(pt4,'  pt_4');
        scatter(pt1(1), pt1(2), 'b', '*');
        scatter(pt2(1), pt2(2), 'b', '*');
        scatter(pt3(1), pt3(2), 'b', '*');
        scatter(pt4(1), pt4(2), 'b', '*');
        
        % esbozar la curva 1-2-3-4
        curve1 = bezier_cubic(pt1, pt2, pt3, pt4, samples);
        plot(curve1(1,:), curve1(2,:), 'b');
        
        % mostrar 3 puntos extras 5-7
        placelabel(pt5,'  pt_5');
        placelabel(pt6,'  pt_6');
        placelabel(pt7,'  pt_7');
        scatter(pt5(1), pt5(2), 'b', '*');
        scatter(pt6(1), pt6(2), 'b', '*');
        scatter(pt7(1), pt7(2), 'b', '*');
        
        % esbozar la curva 4-5-6-7
        curve2 = bezier_cubic(pt4, pt5, pt6, pt7, samples);
        plot(curve2(1,:), curve2(2,:), 'r');
        
        % mostrar 3 puntos extras 8-10
        placelabel(pt8,'  pt_8');
        placelabel(pt9,'  pt_9');
        placelabel(pt10,' pt_10');
        scatter(pt8(1), pt8(2), 'b', '*');
        scatter(pt9(1), pt9(2), 'b', '*');
        scatter(pt10(1),pt10(2),'b', '*');
        
        % esbozar la curva 7-8-9-10
        curve3 = bezier_cubic(pt7, pt8, pt9, pt10, samples);
        plot(curve3(1,:), curve3(2,:), 'y');
        
        % mostrar 3 puntos extras 8-10
        placelabel(pt11,'  pt_11');
        placelabel(pt12,'  pt_12');
        scatter(pt11(1), pt11(2), 'b', '*');
        scatter(pt12(1), pt12(2), 'b', '*');
        
        % esbozar la curva 7-8-9-10
        curve4 = bezier_cubic(pt10, pt11, pt12, pt1, samples);
        plot(curve4(1,:), curve4(2,:), 'c');
        
        transform = @(pt) pt * scale + translation;
        
        min_pt1 = transform(pt1);
        min_pt2 = transform(pt2);
        min_pt3 = transform(pt3);
        min_pt4 = transform(pt4);
        min_pt5 = transform(pt5);
        min_pt6 = transform(pt6);
        min_pt7 = transform(pt7);
        min_pt8 = transform(pt8);
        min_pt9 = transform(pt9);
        min_pt10= transform(pt10);
        min_pt11= transform(pt11);
        min_pt12= transform(pt12);
        % esbozar la curva 1-2-3-4
        min_curve1 = bezier_cubic(min_pt1, min_pt2, min_pt3, min_pt4, samples);
        plot(min_curve1(1,:), min_curve1(2,:), 'b');
        % esbozar la curva 4-5-6-7
        min_curve2 = bezier_cubic(min_pt4, min_pt5, min_pt6, min_pt7, samples);
        plot(min_curve2(1,:), min_curve2(2,:), 'r');
        % esbozar la curva 7-8-9-10
        min_curve3 = bezier_cubic(min_pt7, min_pt8, min_pt9, min_pt10, samples);
        plot(min_curve3(1,:), min_curve3(2,:), 'y');
        min_curve4 = bezier_cubic(min_pt10, min_pt11, min_pt12, min_pt1, samples);
        plot(min_curve4(1,:), min_curve4(2,:), 'c');
        
        hold off;
    end
    
    plot_4_curve([5, -10], [13, -2], [5, 20],  [25, 20],... 
                 [45, 20], [35, -2], [43, -10],...
                 [50,-18], [20,-18], [13, -10],...
                 [6, 0],   [-4,-17],...
                 samples, 0.5, [10, 0]);
    
             
    % Ejercicio 1.2.4 – Entrega el 8 de Octubre 2018, 23:59
    % Crea una imagen en la que aparezca una letra cualquiera (ejemplo), 
    % y cárgala como imagen de fondo de un figure 
    % como se hace en el principio de la función 
    % function bezier_over_letter() que se muestra a continuación. 
    % Completa el resto de la función de manera que la silueta de la letra 
    % se aproxime mediante curvas de Bezier cúbicas. 
    % Una vez tengas todas curvas necesarias, 
    % escálalas para obtener la misma letra más grande y más pequeña.
    function bezier_over_letter()
        figure
        
        img = imread('d.jpg'); %  actualizar path a imagen
        image('CData',img,'XData',[-100 100],'YData',[100 -100])

        xlim([-100 100])
        ylim([-100 100])

        axis equal
        grid on;
        hold on;

        % completar
        % primero los puntos
        pt1 = [30; 25];
        scatter(pt1(1),pt1(2),'b', '*');
        placelabel(pt1,'  pt_1');
        
        pt2 = [-100; 130];
        scatter(pt2(1),pt2(2),'b', '*');
        placelabel(pt2,'  pt_2');
        
        pt3 = [-100;-180];
        scatter(pt3(1),pt3(2),'b', '*');
        placelabel(pt3,'  pt_3');
        
        pt4 = [30;   -70];
        scatter(pt4(1),pt4(2),'b', '*');
        placelabel(pt4,'  pt_4');
        
        curve1 = bezier_cubic(pt1, pt2, pt3, pt4, samples);
        plot(curve1(1,:), curve1(2,:), 'b');
        
        pt5 = [30;    80];
        scatter(pt5(1),pt5(2),'b', '*');
        placelabel(pt5,'  pt_5');
        
        curve2 = bezier_cubic(pt1, pt1, pt5, pt5, samples);
        plot(curve2(1,:), curve2(2,:), 'b');
        
        pt6 = [30;   100];
        scatter(pt6(1),pt6(2),'b', '*');
        placelabel(pt6,'  pt_6');
        
        pt7 = [65;   100];
        scatter(pt7(1),pt7(2),'b', '*');
        placelabel(pt7,'  pt_7');
        
        pt8 = [65;    80];
        scatter(pt8(1),pt8(2),'b', '*');
        placelabel(pt8,'  pt_8');
        curve3 = bezier_cubic(pt5, pt6, pt7, pt8, samples);
        plot(curve3(1,:), curve3(2,:), 'b');
        
        pt9 = [65;   -70];
        scatter(pt9(1),pt9(2),'b', '*');
        placelabel(pt9,'  pt_9');
        
        curve4 = bezier_cubic(pt8, pt8, pt9, pt9, samples);
        plot(curve4(1,:), curve4(2,:), 'b');
        
        pt10 = [65; -100];
        scatter(pt10(1),pt10(2),'b', '*');
        placelabel(pt10,'  pt_10');
        
        pt11 = [30; -100];
        scatter(pt11(1),pt11(2),'b', '*');
        placelabel(pt11,'  pt_11');
        
        curve5 = bezier_cubic(pt9, pt10, pt11, pt4, samples);
        plot(curve5(1,:), curve5(2,:), 'b');
        
        pt12 = [-5;  -65];
        scatter(pt12(1),pt12(2),'b', '*');
        placelabel(pt12,'  pt_12');
        
        pt13 = [-5;   20];
        scatter(pt13(1),pt13(2),'b', '*');
        placelabel(pt13,'  pt_13');
        
        pt14 = [-45; -60];
        scatter(pt14(1),pt14(2),'b', '*');
        placelabel(pt14,'  pt_14');
        
        pt15 = [-45;  10];
        scatter(pt15(1),pt15(2),'b', '*');
        placelabel(pt15,'  pt_15');
        
        curve6 = bezier_cubic(pt12, pt14, pt15, pt13, samples);
        plot(curve6(1,:), curve6(2,:), 'b');
        
        pt16 = [40;  -65];
        scatter(pt16(1),pt16(2),'b', '*');
        placelabel(pt16,'  pt_16');
        
        pt17 = [40;   15];
        scatter(pt17(1),pt17(2),'b', '*');
        placelabel(pt17,'  pt_17');
        
        curve7 = bezier_cubic(pt12, pt16, pt17, pt13, samples);
        plot(curve7(1,:), curve7(2,:), 'b');
        hold off;
        
        figure;
        xlim([-200 200]);
        ylim([-200 200]);
        axis equal;
        grid on;
        hold on;
        transform = @(pt) pt * 1.5;
        scaled_pt1 = transform(pt1);
        scaled_pt2 = transform(pt2);
        scaled_pt3 = transform(pt3);
        scaled_pt4 = transform(pt4);
        scaled_pt5 = transform(pt5);
        scaled_pt6 = transform(pt6);
        scaled_pt7 = transform(pt7);
        scaled_pt8 = transform(pt8);
        scaled_pt9 = transform(pt9);
        scaled_pt10= transform(pt10);
        scaled_pt11 = transform(pt11);
        scaled_pt12 = transform(pt12);
        scaled_pt13 = transform(pt13);
        scaled_pt14 = transform(pt14);
        scaled_pt15 = transform(pt15);
        scaled_pt16 = transform(pt16);
        scaled_pt17 = transform(pt17);
        scaled_curve1 = bezier_cubic(scaled_pt1, scaled_pt2, scaled_pt3, scaled_pt4, samples);
        plot(scaled_curve1(1,:), scaled_curve1(2,:), 'r');
        scaled_curve2 = bezier_cubic(scaled_pt1, scaled_pt1, scaled_pt5, scaled_pt5, samples);
        plot(scaled_curve2(1,:), scaled_curve2(2,:), 'r');
        scaled_curve3 = bezier_cubic(scaled_pt5, scaled_pt6, scaled_pt7, scaled_pt8, samples);
        plot(scaled_curve3(1,:), scaled_curve3(2,:), 'r');
        scaled_curve4 = bezier_cubic(scaled_pt8, scaled_pt8, scaled_pt9, scaled_pt9, samples);
        plot(scaled_curve4(1,:), scaled_curve4(2,:), 'r');
        scaled_curve5 = bezier_cubic(scaled_pt9, scaled_pt10, scaled_pt11, scaled_pt4, samples);
        plot(scaled_curve5(1,:), scaled_curve5(2,:), 'r');
        scaled_curve6 = bezier_cubic(scaled_pt12, scaled_pt14, scaled_pt15, scaled_pt13, samples);
        plot(scaled_curve6(1,:), scaled_curve6(2,:), 'r');
        scaled_curve7 = bezier_cubic(scaled_pt12, scaled_pt16, scaled_pt17, scaled_pt13, samples);
        plot(scaled_curve7(1,:), scaled_curve7(2,:), 'r');
        
        hold off;
    end
       
    bezier_over_letter();
end