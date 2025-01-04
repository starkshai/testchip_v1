function t_half = findHalftime(t,v,vmid,twin)%find half time of rising edge
    Vmax=mean(v(1,500:600));
    Vmin=mean(v(1,1:100));
    Vmean=(Vmax+Vmin)/2;
    threhigh=Vmin+0.7*(Vmax-Vmin);
    threlow=Vmin+0.3*(Vmax-Vmin);
    t_low_pos=1;
    t_high_pos=1;
    t_mean_pos=1;
    extendp=15;
    find_mean=0;
    %find middle point
    for i=twin(1):twin(2)
        if(v(1,i)>=Vmean && find_mean==0)
            for j=1:extendp
                if(v(1,i+j)>=threhigh)
                    t_mean_pos=i;
                    find_mean=1;
                    t_high_pos=i+j;
                    break
                end
            end      
        end
        if(find_mean==1)
            break
        end
    end
    for i=twin(1):t_mean_pos
        if(v(1,i)>=threlow)
            t_low_pos=i-1;
            break
        end
    end
    p=polyfit(t(1,t_low_pos:t_high_pos),v(1,t_low_pos:t_high_pos),1);


    t_half=(vmid-p(2))/p(1);
end