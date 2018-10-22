function main
while(true)
    tx = 3 * rand(1,1);
    ty = 3 * rand(1,1);
    target = [tx, ty]; % añadimos un objetivo aleatorio
    run_IK(target);
end
run_IK([1, -3]);
    function run_IK(g)
        function [n1, n2, n3, n4] = denavit(skeleton, rots)
            % Dibuja el estado actual
            rot0_matrix = [ 1 0 0;
                0 1 0;
                0 0 1];
            
            trans0_matrix = [1 0 skeleton(1,1);
                0 1 skeleton(1,2);
                0 0 1];
            
            pos             = rot0_matrix * trans0_matrix;
            n1 = [pos(1,3),pos(2,3)];
            
            % Aplicamos nodo 1
            rot1_matrix = [ +cosd(rots(1)) -sind(rots(1)) 0;
                +sind(rots(1)) +cosd(rots(1)) 0;
                0          0          1 ];
            
            trans1_matrix = [1 0 skeleton(2,1);
                0 1 skeleton(2,2);
                0 0 1];
            
            old_pos = pos;
            pos     =   rot0_matrix * trans0_matrix ...
                * rot1_matrix * trans1_matrix ;
            
            n2 = [pos(1,3),pos(2,3)];
            
            % Aplicamos nodo 2
            rot2_matrix = [ +cosd(rots(2)) -sind(rots(2)) 0;
                +sind(rots(2)) +cosd(rots(2)) 0;
                0          0          1 ];
            
            trans2_matrix = [1 0 skeleton(3,1);
                0 1 skeleton(3,2);
                0 0 1];
            
            old_pos = pos;
            pos     =   rot0_matrix * trans0_matrix * ...
                rot1_matrix * trans1_matrix * ...
                rot2_matrix * trans2_matrix ;
            n3 = [pos(1,3),pos(2,3)];
            
            % Aplicamos nodo 3
            rot3_matrix = [ +cosd(rots(3)) -sind(rots(3)) 0;
                +sind(rots(3)) +cosd(rots(3)) 0;
                0          0          1 ];
            
            trans3_matrix = [1 0 skeleton(4,1);
                0 1 skeleton(4,2);
                0 0 1];
            
            old_pos = pos;
            pos     =   rot0_matrix * trans0_matrix * ...
                rot1_matrix * trans1_matrix * ...
                rot2_matrix * trans2_matrix * ...
                rot3_matrix * trans3_matrix;
            
            n4 = [pos(1,3),pos(2,3)];
        end
        close all;
        
        trans0 = [0,0];
        trans1 = [1,1]; % Offset con respecto joint 0
        trans2 = [1,1];  % Offset con respecto joint 1
        trans3 = [1,1];  % Offset con respecto joint 2
        
        error = @(source, target) norm(target-source);
        
        skeleton = [trans0; trans1; trans2; trans3];
        e = trans0+trans1+trans2+trans3;
        rots = [0, 0, 0]; % Rotacion local del joint
        alpha = 0.5;
        
        figure;
        hold on;
        grid on;
        axis equal;
        xlim([-5 5]);
        ylim([-5 5]);
        
        scatter(g(1),g(2),100,'m','filled','p');
        node1 = scatter(0, 0,300,'o','filled');
        node2 = scatter(0, 0,300,'o','filled');
        node3 = scatter(0, 0,300,'o','filled');
        node4 = scatter(0, 0,300,'o','filled');
        line1 = line([0,0],[0,0], 'LineWidth', 2);
        line2 = line([0,0],[0,0], 'LineWidth', 2);
        line3 = line([0,0],[0,0], 'LineWidth', 2);
        while(error(e, g) > 0.1)
            [n1, n2, n3, n4] = denavit(skeleton, rots);
            set(node1, 'XData',n1(1), 'YData',n1(2));
            set(node2, 'XData',n2(1), 'YData',n2(2));
            set(line1, 'XData',[n2(1),n1(1)], 'YData',[n2(2),n1(2)]);
            set(node3, 'XData',n3(1), 'YData',n3(2));
            set(line2, 'XData',[n3(1),n2(1)], 'YData',[n3(2),n2(2)]);
            set(node4, 'XData',n4(1), 'YData',n4(2));
            set(line3, 'XData',[n4(1),n3(1)], 'YData',[n4(2),n3(2)]);
            drawnow;
            e = n4;
            err = error(e, g);
            disp(err);
            
            % Calcula Jacobiano del estado actual
            d_theta = 0.1 * [1, 1, 1];
            [n1, new_n2 ,new_n3, new_e] = denavit(skeleton, rots + d_theta);
            J = transpose([new_n2;new_n3;new_e]-[n2; n3; n4])./d_theta;
            disp(J);
            
            % Calcula posicion actual del end effector
            
            % calcular pseudoinversa de J —> J+
            J_plus = pinv(J);
            
            % Calcula incrementos de las rotaciones
            d_theta = transpose(J_plus * transpose(g-e));
            
            % Actualiza rotaciones
            rots = rots + alpha * d_theta;
            
            pause(1);
        end
        
        hold off;
    end
end