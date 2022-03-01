clear
close all
clc
% параметры
T_0 = 0;
T_k = 100;
T_d = 0.001;
Fd=1000;
N_t = (T_k - T_0)/T_d + 1;

FftL=100000;
F = T_0:Fd/FftL:Fd/2-1/FftL;

% создание вектора времени
t = linspace(T_0, T_k, N_t);
% вариант 5
var = 5;
    
    
% для синусойдного сигнала

% % график синусоиды
sig_sin = 1.5*sin(18.5*2*pi*t);
sig_spec1 = abs(fft(sig_sin,FftL));
% sig_spec1 = fftshift(sig_spec1);
figure;
plot(t, sig_sin);
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
title('График синусоиды');
grid()
ylabel('Амплитуда')
xlabel('Время, с')



%график спектра синусоиды
figure;
sig_spec1 = 2*sig_spec1./FftL;
sig_spec1(1) = sig_spec1(1)/2;
plot(F,sig_spec1(1:length(F)));
xlim([0, 25]);
title('График спектра синусоиды');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')



%для меандра

% график меандра
sig_meandr = 1.5*square(18.5*2*pi*t);
sig_spec2 = abs(fft(sig_meandr));
% sig_spec2 = fftshift(sig_spec2);
figure;
plot(t, sig_meandr)
title('График меандра');
grid()
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
ylabel('Амплитуда')
xlabel('Время, с')

% % график спектра меандра
figure;
sig_spec2 = 2*sig_spec2./FftL;
sig_spec2(1) = sig_spec2(1)/2;
plot(F,sig_spec2(1:length(F)));
xlim([0, 25]);
title('График спектра меандра');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')



%для пилообразного сигнала

% график пилообразного сигнала
sig_saw = 1.5*sawtooth(18.5*2*pi*t);
sig_spec3 = abs(fft(sig_saw));
figure;
plot(t, sig_saw)
title('График пилообразного сигнала');
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
grid()
ylabel('Амплитуда')
xlabel('Время, с')

% график спектра пилообразного сигнала
% figure;
% sig_spec3 = 2*sig_spec3./FftL;
% sig_spec3(1) = sig_spec3(1)/2;
% plot(F,sig_spec3(1:length(F)));
% xlim([0, 25]);
% title('График спектра пилообразного сигнала');
% grid()
% ylabel('Амплитуда')
% xlabel('Частота,Гц')



% идеальное реле для синусоиды

sig_sin_after_relay = sign(sig_sin);
spec_sig_sin_after_relay = abs(fft(sig_sin_after_relay));

%График спектра синусоиды после идеального реле
figure;
spec_sig_sin_after_relay = 2*spec_sig_sin_after_relay./FftL;
spec_sig_sin_after_relay(1) = spec_sig_sin_after_relay(1)/2;
plot(F,spec_sig_sin_after_relay(1:length(F)));
xlim([0, 25]);
title('График спектра синусоиды после идеального реле');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')

%График синусоиды до и после идеального реле
figure;
hold on
plot(t, sig_sin);
plot(t, sig_sin_after_relay);
xlim([0, 0.5]);
title('График синусоиды до и после идеального реле');
legend('Синусоида до идеального реле','Синусоида после идеального реле')
grid()
ylabel('Амплитуда')
xlabel('Время, с')
hold off



% идеальное реле для меандра

sig_meandr_after_relay = sign(sig_meandr);
spec_sig_meandr_after_relay = abs(fft(sig_meandr_after_relay));

%График спектра меандра после идеального реле
figure;
spec_sig_meandr_after_relay = 2*spec_sig_meandr_after_relay./FftL;
spec_sig_meandr_after_relay(1) = spec_sig_meandr_after_relay(1)/2;
plot(F,spec_sig_meandr_after_relay(1:length(F)));
xlim([0, 25]);
title('График спектра меандра после идеального реле');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')
%
% %График меандра до и после идеального реле
figure;
hold on
plot(t, sig_meandr);
plot(t, sig_meandr_after_relay);
xlim([0, 0.5]);
title('График меандра до и после идеального реле');
legend('Меандр до идеального реле','Меандр после идеального реле')
grid()
ylabel('Амплитуда')
xlabel('Время, с')
hold off



% идеальное реле для пилообразного сигнала

sig_saw_after_relay = sign(sig_saw);
spec_sig_saw_after_relay = abs(fft(sig_saw_after_relay));

% %График спектра пилообразного сигнала после идеального реле
figure;
spec_sig_saw_after_relay = 2*spec_sig_saw_after_relay./FftL;
spec_sig_saw_after_relay(1) = spec_sig_saw_after_relay(1)/2;
plot(F,spec_sig_saw_after_relay(1:length(F)));
xlim([0, 25]);
title('График спектра пилообразного сигнала после идеального реле');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')
%
% %График пилообразного сигнала после идеального реле
figure;
hold on
plot(t, sig_saw);
plot(t, sig_saw_after_relay);
xlim([0, 0.5]);
title('График пилообразного сигнала после идеального реле');
legend('Пилообразный сигнал до идеального реле','Пилообразный сигнал после идеального реле')
grid()
ylabel('Амплитуда')
xlabel('Время, с')
hold off



%реле с мертвой зоной для синусоиды
k=1;
for i = T_0:T_d:T_k
sig_sin_after_relay_dead(k) = dead_zone_scalar(sig_sin(k));
k=k+1;
end
figure
hold on
plot(t, sig_sin);
plot(t, sig_sin_after_relay_dead);
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
title('График синусоиды');
grid()
legend('Синусоида до реле с мертвой зоной','Синусоида после реле с мертвой зоной')
ylabel('Амплитуда')
xlabel('Время, с')
hold off

%график спектра синусоиды
sig_spec7 = abs(fft(sig_sin_after_relay_dead,FftL));
figure;
sig_spec7 = 2*sig_spec7./FftL;
sig_spec7(1) = sig_spec7(1)/2;
% plot(F, sig_spec1);
plot(F,sig_spec7(1:length(F)));
xlim([0, 25]);
title('График спектра синусоиды');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')
%
%
% %       
% 
% реле с мертвой зоной для меандра
k=1;
for i = T_0:T_d:T_k
sig_meandr_after_relay_dead(k) = dead_zone_scalar(sig_meandr(k));
k=k+1;
end
figure
hold on
plot(t, sig_meandr);
plot(t, sig_meandr_after_relay_dead);
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
title('График меандра');
grid()
legend('Меандр до реле с мертвой зоной','Меандр после реле с мертвой зоной')
ylabel('Амплитуда')
xlabel('Время, с')
hold off

%график спектра меандра
sig_spec8 = abs(fft(sig_meandr_after_relay_dead,FftL));
figure;
sig_spec8 = 2*sig_spec8./FftL;
sig_spec8(1) = sig_spec8(1)/2;
% plot(F, sig_spec1);
plot(F,sig_spec8(1:length(F)));
xlim([0, 25]);
title('График спектра меандра');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')

% реле с мертвой зоной для пилообразного сигнала
k=1;
for i = T_0:T_d:T_k
sig_saw_after_relay_dead(k) = dead_zone_scalar(sig_saw(k));
k=k+1;
end

figure
hold on
plot(t, sig_saw);
plot(t, sig_saw_after_relay_dead);
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
title('График пилообразного сигнала');
grid()
legend('Пилообразный сигнал до реле с мертвой зоной','Пилообразный сигнал после реле с мертвой зоной')
ylabel('Амплитуда')
xlabel('Время, с')
hold off

%график спектра пилообразного сигнала
sig_spec9 = abs(fft(sig_saw_after_relay_dead,FftL));
figure;
sig_spec9 = 2*sig_spec9./FftL;
sig_spec9(1) = sig_spec9(1)/2;
% plot(F, sig_spec1);
plot(F,sig_spec9(1:length(F)));
xlim([0, 25]);
title('График спектра пилообразного сигнала');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')



    %реле с насыщением для синусоиды
k=1;
for i = T_0:T_d:T_k
sig_sin_after_relay_saturation(k) = saturation_scalar(sig_sin(k));
k=k+1;
end

figure
hold on
plot(t, sig_sin);
plot(t, sig_sin_after_relay_saturation);
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
title('График синусоиды');
grid()
legend('Синусоида до реле с насыщением','Синусоида после реле с насыщением')
ylabel('Амплитуда')
xlabel('Время, с')
hold off

%график спектра пилообразного сигнала
sig_spec10 = abs(fft(sig_sin_after_relay_saturation,FftL));
figure;
sig_spec10 = 2*sig_spec10./FftL;
sig_spec10(1) = sig_spec10(1)/2;
% plot(F, sig_spec1);
plot(F,sig_spec10(1:length(F)));
xlim([0, 25]);
title('График спектра синусоиды');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')

% реле с насыщением для меандра
k=1;
for i = T_0:T_d:T_k
sig_meandr_after_relay_saturation(k) = saturation_scalar(sig_meandr(k));
k=k+1;
end

figure
hold on
plot(t, sig_sin);
plot(t, sig_meandr_after_relay_saturation);
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
title('График меандра');
grid()
legend('Меандр до реле с насыщением','Меандр после реле с насыщением')
ylabel('Амплитуда')
xlabel('Время, с')
hold off

%график спектра меандра
sig_spec11 = abs(fft(sig_sin_after_relay_saturation,FftL));
figure;
sig_spec11 = 2*sig_spec11./FftL;
sig_spec11(1) = sig_spec11(1)/2;
% plot(F, sig_spec1);
plot(F,sig_spec11(1:length(F)));
xlim([0, 25]);
title('График спектра меандра');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')

%реле с насыщением для пилообразного сигнала
k=1;
for i = T_0:T_d:T_k
sig_saw_after_relay_saturation(k) = saturation_scalar(sig_saw(k));
k=k+1;
end

figure
hold on
plot(t, sig_saw);
plot(t, sig_saw_after_relay_saturation);
xlim([0, 1.1]);
ylim([-1.6, 1.6]);
title('График пилообразного сигнала');
grid()
legend('Пилообразный сигнал до реле с насыщением','Пилообразный сигнал после реле с насыщением')
ylabel('Амплитуда')
xlabel('Время, с')
hold off

%график спектра пилообразного сигнала
sig_spec12 = abs(fft(sig_sin_after_relay_saturation,FftL));
figure;
sig_spec12 = 2*sig_spec12./FftL;
sig_spec12(1) = sig_spec12(1)/2;
% plot(F, sig_spec1);
plot(F,sig_spec12(1:length(F)));
xlim([0, 25]);
title('График спектра пилообразного сигнала');
grid()
ylabel('Амплитуда')
xlabel('Частота,Гц')

%БИХ фильтр
k = 2;
T = 1.1;
b = [ k/(1+T/0.01) ];
a = [1, -1/(1+0.01/T)];



    % реле с мертвой зоной
    function y = dead_zone_scalar(x)
%         width = 0.5;
       width = 1;
        if abs(x)<width
            y=0;
        elseif x>0
            y=x-width;
        else
            y = x+width;
        end
    end
    %усилитель с насыщением
    function y = saturation_scalar(x)
%       hight = 0.5;
      hight = 1;
      if abs(x)<hight
          y=x;
      elseif x>0
          y=hight;
      else
          y=-hight;
      end
    end



