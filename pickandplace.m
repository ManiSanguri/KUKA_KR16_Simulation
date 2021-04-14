function [end_test, place_pos, above_place_pos, above_pickup_pos]= pick_and_place(origine_table, length_nbre, width_nbre, height_nbre, cube_dimensions, width_offset, length_offset, place_pos,above_place_pos, above_pickup_pos)
end_test = 0;
persistent w l h %declare the static variable
if isempty(w)
    w=1;
end
if isempty(l)
    l=1;
end
if isempty(h)
    h=1;
end
if (w<width_nbre)
    place_pos(1) = place_pos(1)+cube_dimensions(2)+width_offset;
    above_place_pos(1) = above_place_pos(1)+cube_dimensions(2)+width_offset;
    w =w+1;
else
    place_pos(1) = origine_table(1);
    above_place_pos(1) = origine_table(1);
    w = 1;
    if (l<length_nbre)
        place_pos(2) = place_pos(2)+cube_dimensions(1)+length_offset;
        above_place_pos(2) = above_place_pos(2)+cube_dimensions(1)+length_offset;
        l = l+1;
    else
        place_pos(2) = origine_table(2);
        above_place_pos(2)= origine_table(2);
        l=1;
        if (h<height_nbre)
            place_pos(3) = place_pos(3)+cube_dimensions(3);
            above_place_pos(3) = above_place_pos(3)+cube_dimensions(3);
            above_pickup_pos(3) = above_pickup_pos(3)+cube_dimensions(3);
            h = h+1;
        else
            end_test = 1;
        end
    end
end
    
end
