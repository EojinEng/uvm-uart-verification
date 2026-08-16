# UART RTL Design & UVM Verification

> **SystemVerilog를 UVM 환경 기반 기능 검증을 수행한 프로젝트입니다.
> TX/RX Agent 및 Env를 독립적으로 구현함으로써, 다른 시스템에서도 UART 검증이 가능하도록 재사용성을 높인 구조입니다.**

---

# 프로젝트 소개

본 프로젝트는 **9600 Baud Rate, 16x Oversampling** 기반의 UART RTL을 설계하고,
**UVM(Universal Verification Methodology)** 환경에서 기능 검증을 수행하였습니다.

TX Agent에서 Random Transaction을 생성하여 DUT에 입력하고,
UART의 TX와 RX를 Loopback 구조로 연결하여 실제 송수신 환경과 동일한 방식으로 검증을 진행하였습니다.

또한 TX Monitor와 RX Monitor에서 수집한 Transaction을 Scoreboard에서 비교하여 데이터의 정합성을 확인하였으며,
Functional Coverage를 통해 다양한 데이터 패턴에 대한 검증을 수행하였습니다.

---

# 프로젝트 사양

| 항목 | 내용 |
| :--- | :--- |
| Language | SystemVerilog |
| Verification Methodology | UVM |
| Baud Rate | 9600 bps |
| Oversampling | 16 Tick |
| Data Width | 8-bit |
| Start Bit | 1 |
| Stop Bit | 1 |
| Parity | None |

---

# UART RTL 구조

<img width="1217" height="912" alt="image" src="https://github.com/user-attachments/assets/1509dd83-1858-40cc-bd05-74ef62d3ba84" />

> UART TX와 UART RX를 포함하는 전체 RTL 구조를 나타낸 블록도

---

# UVM Verification Architecture

<img width="769" height="672" alt="image" src="https://github.com/user-attachments/assets/079c2578-3e77-425d-a58c-dc2e48ca5f69" />

- uart_Test
- uart_Environment
- uart_tx_Agent (uart_tx_driver, uart_tx_monitor)
- uart_rx_Agent (uart_rx_driver, uart_rx_monitor)
- uart_Scoreboard
- uart_Coverage
- UART DUT

---

# Verification Flow

<img width="1421" height="425" alt="image" src="https://github.com/user-attachments/assets/cf97645e-92c2-49c1-a3f8-6de8afd26de9" />

검증 과정.
1. Sequence에서 Random Transaction 생성
2. TX Driver가 DUT에 데이터 전송
3. UART DUT에서 데이터 송신
4. DUT 내부 Loopback을 통해 RX 입력으로 전달
5. RX Monitor가 수신 데이터 추출
6. Scoreboard에서 TX와 RX 데이터를 비교
7. Functional Coverage 수집

---

# 프로젝트 구조

```text
rtl
├── uart_tx.sv
├── uart_rx.sv
└── uart_top.sv

tb
├── interface
├── sequence_item
├── sequence
├── sequencer
├── driver
├── monitor
├── agent
├── scoreboard
├── coverage
├── env
└── test
```

---

# 검증 결과

- UART TX/RX 기능 정상 동작 확인
- 9600 Baud Rate 정상 동작
- 16x Oversampling 정상 동작
- Loopback 환경에서 송수신 데이터 검증 완료
- Scoreboard 비교 결과 PASS
- Functional Coverage 수집 완료
- Verdi Waveform을 이용한 기능 검증 완료

---

# Trouble Shooting

## Clocking Block Synchronization Mismatch

### 문제

RX Monitor에서 `rx_done` 이벤트는 정상적으로 발생했지만, Scoreboard에서 RX 데이터가 TX 데이터와 일치하지 않는 문제가 발생.

원인을 분석한 결과, 이벤트를 감지하는 기준과 데이터를 샘플링하는 기준이 서로 달라 발생한 **Synchronization Mismatch** 문제.

---

### 문제 코드

```systemverilog
@(posedge u_if.rx_done);
mon_rx_item.rx_data = u_if.mon_cb.rx_data;
```

- Event Trigger : `@(posedge u_if.rx_done)`
- Data Sampling : `u_if.mon_cb.rx_data`

`rx_done`은 Interface의 실제 신호를 기준으로 이벤트를 감지하지만,

`rx_data`는 Clocking Block(`mon_cb`)을 통해 샘플링된 값을 읽고 있었음.

---

### 원인 분석

처음에는 `@(posedge u_if.rx_done)`가 발생한 이후에 `mon_cb.rx_data`를 읽으므로 최신 데이터가 전달될 것이라고 생각함.

하지만 `mon_cb.rx_data`는 이벤트가 발생하는 순간 값을 읽는 것이 아니라, Clocking Block의 Sampling 규칙에 따라 **매 Clock Event마다 미리 샘플링된 값**을 반환.

따라서 `rx_done`이 발생한 직후 데이터를 읽더라도, 실제로는 이전 Clock에서 샘플링된 값이 Transaction에 저장되는 걸 확인함.

즉,

```
Event Trigger
    ↓
@(posedge u_if.rx_done)

Data Read
    ↓
u_if.mon_cb.rx_data

→ Clocking Block에서 이전에 샘플링한 값 반환
```

이로 인해 RX Transaction에 이전 데이터가 저장되는 문제가 발생하였던 것.

---

### 해결

이벤트 감지와 데이터 샘플링 기준을 모두 Clocking Block으로 통일하여 줌.

```systemverilog
@(posedge u_if.mon_cb.rx_done);
mon_rx_item.rx_data = u_if.mon_cb.rx_data;
```

Clocking Block을 사용하는 경우에는 **이벤트 감지와 데이터 샘플링 모두 동일한 Clocking Block 기준으로 동작하도록 작성해야 한다**는 점을 확인함.
또한 **이벤트 감지와 무관하게 데이터 샘플링 해당 기준에 맞게 항상 동작한다**는 것을 확인함.

---

### 결과

- Synchronization Mismatch 해결
- RX Transaction 정상 생성
- Scoreboard에서 TX/RX 데이터 정상 비교
- Loopback 검증 PASS

---

# 개발 환경

| 항목 | 내용 |
| :--- | :--- |
| OS | Linux |
| Language | SystemVerilog |
| Verification | UVM |
| Waveform | Verdi |

---
