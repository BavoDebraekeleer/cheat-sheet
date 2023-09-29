| Naam         | Sync/Async | Type              | Duplex | Max devices | Distance | Pins | Pin names           |
| ------------ | ---------- | ----------------- | ------ | ----------- | -------- | ---- | ------------------- |
| UART RS232   | Asynchroon | 1-1               | Full   | 2           | 15m      | 2    | RX, TX              |
| UART RS422   | Asynchroon | 1-1               | Full   | 2           | 1200m    | 4    | ±RX, ±TX            |
| UART RS485   | Asynchroon | m-(multi)s        | Full   | 32          | 1200m    | 4    | ±RX, ±TX            |
| I²C, TWI     | Synchroon  | (multi)m-(multi)s | Half   | ∞           | 10m      | 2    | SCL, SDA            |
| SPI (4 wire) | Synchroon  | m-(multi)s        | Full   | ∞           |          | 4    | SCL, MOSI, MISO, SS |
| SPI (3 wire) | Synchroon  | m-(multi)s        | HAlf   | ∞           |          | 3    | SCL, SISO, SS       |

