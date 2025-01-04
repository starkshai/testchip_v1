function [t_half,fail_numb] = findHalftime(t,v,vmid)%find half time of rising edge
    Vmax=max(v);
    Vmin=min(v);
    threhigh=Vmin+0.8*(Vmax-Vmin);
    threlow=Vmin+0.2*(Vmax-Vmin);
    t_low_pos=1;
    t_high_pos=1;
    fail_numb=0;
    for i=1:length(t)
        if(v(1,i)>=threlow)
            t_low_pos=i;
            break      
        end
    end
    for i=t_low_pos:length(t)
        if(v(1,i)>=threhigh)
            t_high_pos=i;
            break
        end
    end
    if(Vmax<(Vmin+300))%no rising in the window
        t_half=t(1,end);
        fail_numb=fail_numb+1;
    else
        p=polyfit(t(1,t_low_pos:t_high_pos),v(1,t_low_pos:t_high_pos),1);
        t_half=(vmid-p(2))/p(1);
    end
end