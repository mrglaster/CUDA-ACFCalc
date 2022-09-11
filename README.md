## Finding the length N signal with smallest ACF sidelobe using CUDA technology

Programm for searching for the optimal signal using CUDA technology. The task of summer student practice for first-year students of the ISU FBCI faculty, 2022. 

Purpose of the work: search for the optimal signal by its autocorrelation function, namely the sidelobe amplitude, using parallel computing using the CUDA (Compute Unified Device Architecture) technology developed by the Nvidia Corporation.
To search for periodicity, an autocorrelation function will be used, which shows the dependence between the signal and its shifted copy on the magnitude of the time shift. For deterministic signals, the autocorrelation function is given by the following formula:

![alt text](https://github.com/mrglaster/cuda-ACF-calculations/blob/main/images/f1.png?raw=true)

Thanks to the autocorrelation function, it will be possible to determine the periodicity of the signal, as well as its sidelobe amplitude. The amplitude of the sidelobe should be the smallest so that when adding noise, it would not be possible to confuse the sidelobe with the main one. Such signals are optimal.

### The "good" signal example 

![alt text](https://github.com/mrglaster/cuda-ACF-calculations/blob/main/images/f2.png?raw=true)

## Calculation Results 

| Signal Length | Signal                                         | Signal Dec     | ACF | Calculation time (mks) |
|:---------------:|:------------------------------------------------:|:----------------:|:-----:|:------------------------:|
| 5             | 10111                                          | 23             | 1   | 77700                  |
| 6             | 110111                                         | 55             | 2   | 42                     |
| 7             | 1110010                                        | 114            | 1   | 38                     |
| 8             | 11001011                                       | 203            | 2   | 37                     |
| 9             | 111010011                                      | 467            | 2   | 40                     |
| 10            | 1111001010                                     | 970            | 2   | 47                     |
| 11            | 11100010010                                    | 1810           | 1   | 45                     |
| 12            | 111110101100                                   | 4012           | 2   | 54                     |
| 13            | 1010110011111                                  | 5535           | 1   | 63                     |
| 14            | 10101111100110                                 | 11238          | 2   | 102                    |
| 15            | 111101110001011                                | 31627          | 2   | 186                    |
| 16            | 1011101101000010                               | 47939          | 2   | 465                    |
| 17            | 10111011011110000                              | 95984          | 2   | 888                    |
| 18            | 111110100101110000                             | 256371         | 2   | 1801                   |
| 19            | 1011011101110000000                            | 375695         | 2   | 3546                   |
| 20            | 11000000011001000000                           | 788052         | 2   | 7255                   |
| 21            | 111110100010110000000                          | 2049420        | 2   | 14277                  |
| 22            | 1111110110010100000000                         | 4154680        | 3   | 29466                  |
| 23            | 11111011100001000000000                        | 8241842        | 3   | 57578                  |
| 24            | 111111010101100000000000                       | 16603527       | 3   | 114612                 |
| 25            | 1011001001010110000000000                      | 23375843       | 2   | 204651                 |
| 26            | 11111110100101100000000000                     | 66739612       | 3   | 372568                 |
| 27            | 111111100110001000000000000                    | 133371723      | 3   | 721245                 |
| 28            | 1011001001010110000000000000                   | 187006748      | 2   | 1.49172e+06            |
| 29            | 11111101100011000000000000000                  | 531739882      | 3   | 2.95295e+06            |
| 30            | 111111010110101000000000000000                 | 1062899308     | 3   | 6.13721e+06            |
| 31            | 1111110101110010000000000000000                | 2126059873     | 3   | 1.2145e+07             |
| 32            | 11111011110100000000000000000000               | 4224760230     | 3   | 3.14903e+07            |
| 33            | 111111011011001000000000000000000              | 8512697118     | 3   | 8.54967e+07            |
| 34            | 1111111011000010000000000000000000             | 17096972966    | 3   | 1.71062e+08            |
| 35            | 11111110100001100000000000000000000            | 34161844889    | 3   | 3.40751e+08            |
| 36            | 111110110100111000000000000000000000           | 67460226248    | 3   | 6.81486e+08            |
| 37            | 1111110010011010000000000000000000000          | 135617271576   | 3   | 1.36192e+09            |
| 38            | 10101000100100000000000000000000000000         | 180995029262   | 3   | 2.71455e+09            |
| 39            | 111101101110010000000000000000000000000        | 530201777379   | 3   | 5.43187e+09            |
| 40            | 1110001111010100000000000000000000000000       | 978526324872   | 3   | 1.10931e+10            |
| 41            | 11110001100111000000000000000000000000000      | 2075474874957  | 3   | 2.23926e+10            |
| 42            | 111011101110111000000000000000000000000000     | 4104785464139  | 3   | 4.47006e+10            |
| 43            | 1110100101101010000000000000000000000000000    | 8020178802883  | 3   | 8.98576e+10            |
| 44            | 11111001101000100000000000000000000000000000   | 17154872297800 | 3   | 1.79032e+11            |
| 45            | 101110101110011000000000000000000000000000000  | 25688119796594 | 3   | 3.60616e+11            |
| 46            | 1100000000001100000000000000000000000000000000 | 52789931043418 | 3   | 7.18981e+11            |

### Developed by:

Vladislav Novikov,
Vadim Nechaev,
Egor Pristavka


## Links 

1.	Сандерс, Дж. Технология CUDA в примерах. Введение в программирование графических процессоров // Сандерс Дж, Кэдрот Э., Пер. с англ. Слинкина А.А., научный редактор Боресков А.В., М.:ДМК Пресс 2011. – 232 с.: ил. [Электронный ресурс]. Режим доступа: URL: https://drive.google.com/drive/folders/1rHlPvSzYI2t3FZgNdUGlHME6KRufroW2 (дата обращения: 20.06.2022). 
2.	Nvidia developer zone: CUDA toolkit documentation [Электронный ресурс]. Режим доступа: URL: https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html (дата обращения: 23.06.2022).
3.	Профессиональное сообщество «Хабр» [Электронный ресурс]. Режим доступа: URL: https://habr.com/ru/post/151897/ (дата обращения: 23.06.2022).
4.	Профессиональный блог «Русские блоги» [Электронный ресурс]. Режим доступа: URL: https://russianblogs.com/article/6065573220/ (дата обращения: 23.06.2022).

