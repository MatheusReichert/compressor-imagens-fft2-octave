%Matheus Ernan Reichert
%Escrito no  Octave 6.4.0 (2021-10-30)


nomeImagem = 'Lenna'; %titulo da imagem escolhida, deve estar no diretoria de trabalho do octave
extensao= '.png'; %extensao da imagem escolhida
minhaImagem = im2double(imread([nomeImagem,extensao]));  %imagem para matriz do tipo double

%Aplica a transformada rapida de Fourier para matrizes, em coluna e linha
transformada = fft2((minhaImagem));

%É apartir daqui que a imagem é "comprimida", zerando todos os valores abaixo dos limiares definidos

%Ordena os valores da matriz segundo a magnitude, em ordem crescente
transformadaOrdenadaMag = sort(abs(transformada(:))); 
for  keep=[0.999, 0.1 ,0.05, 0.01, 0.001];
 
limiar = transformadaOrdenadaMag(floor((1-keep)*length(transformadaOrdenadaMag)));
menores = abs(transformada)>limiar; % Encontra valores na matriz q permeiam o limiar definido
limitado = transformada.*real(menores); % Limita os valores 

imagemReconstruida= real(ifft2(limitado)); % Reconstroi a imagem usando a funcao inversa de Fourier
%Salva a imagem em disco

imwrite(imagemReconstruida, [nomeImagem," imagem reconstruida com limiar de ",  num2str(keep*100), " % .png"]), Quality = 100;
imwrite(real(fftshift(limitado)), [nomeImagem," transformada com limiar de ",  num2str(keep*100), " % .png"]), Quality = 100;
% Plota 

figure,
imshow(fftshift(real(limitado)));
title([nomeImagem," com limiar de ",  num2str(keep*100), " %"]); 

% Plota a imagem apos reconstrucao
figure,
imshow(imagemReconstruida);
title([nomeImagem ,"com limiar de ",  num2str(keep*100), " %"]); 
end