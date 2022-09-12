## Finding the length N signal with smallest ACF sidelobe using CUDA technology

Programm for searching for the optimal signal using CUDA technology. The task of summer student practice for first-year students of the ISU FBCI faculty, 2022. 

Purpose of the work: search for the optimal signal by its autocorrelation function, namely the sidelobe amplitude, using parallel computing using the CUDA (Compute Unified Device Architecture) technology developed by the Nvidia Corporation.
To search for periodicity, an autocorrelation function will be used, which shows the dependence between the signal and its shifted copy on the magnitude of the time shift. For deterministic signals, the autocorrelation function is given by the following formula:

![alt text](https://github.com/mrglaster/cuda-ACF-calculations/blob/main/images/f1.png?raw=true)

Thanks to the autocorrelation function, it will be possible to determine the periodicity of the signal, as well as its sidelobe amplitude. The amplitude of the sidelobe should be the smallest so that when adding noise, it would not be possible to confuse the sidelobe with the main one. Such signals are optimal.

### The "good" signal example 

![alt text](https://github.com/mrglaster/cuda-ACF-calculations/blob/main/images/f2.png?raw=true)

## Calculation Results 

Check the .dat file in the "Results" folder

### Developed by:

Vadim Nechaev,
Vladislav Novikov,
Egor Pristavka


## Links 

1.	Сандерс, Дж. Технология CUDA в примерах. Введение в программирование графических процессоров // Сандерс Дж, Кэдрот Э., Пер. с англ. Слинкина А.А., научный редактор Боресков А.В., М.:ДМК Пресс 2011. – 232 с.: ил. [Электронный ресурс]. Режим доступа: URL: https://drive.google.com/drive/folders/1rHlPvSzYI2t3FZgNdUGlHME6KRufroW2 (дата обращения: 20.06.2022). 
2.	Nvidia developer zone: CUDA toolkit documentation [Электронный ресурс]. Режим доступа: URL: https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html (дата обращения: 23.06.2022).
3.	Профессиональное сообщество «Хабр» [Электронный ресурс]. Режим доступа: URL: https://habr.com/ru/post/151897/ (дата обращения: 23.06.2022).
4.	Профессиональный блог «Русские блоги» [Электронный ресурс]. Режим доступа: URL: https://russianblogs.com/article/6065573220/ (дата обращения: 23.06.2022).

