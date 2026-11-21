# Enhancing Power System Security Using Machine Learning and FACTS Devices

A final-year academic project focused on power-system security assessment under contingency conditions using machine learning, Flexible AC Transmission System (FACTS) devices, and nature-inspired optimization techniques.

## Project Overview

This repository contains the MATLAB code, simulation data, and results for the project:

**“Enhancing Power System Security under Contingency using Machine Learning, FACTS Devices, and Nature-Inspired Optimization Techniques.”**

## Project Highlights

- Simulated the **IEEE 30-bus** and **IEEE 118-bus** test systems.
- Developed a **Hybrid Line Stability Ranking Index (HLSRI)** for contingency analysis.
- Implemented **Random Forest** and **Gradient Boosting** classifiers, with reported accuracy of **95–96%**.
- Optimized FACTS device placement using **Unified Power Flow Controller (UPFC)** and **Interline Power Flow Controller (IPFC)**.
- Applied **Student Psychology Based Optimization (SPBO)** and **Sparrow Search Algorithm (SSA)** for optimization.
- Evaluated improvements in power-loss reduction and voltage stability.

## Methods and Technologies

| Area | Methods / Tools |
|---|---|
| Simulation systems | IEEE 30-bus and IEEE 118-bus |
| Contingency analysis | Hybrid Line Stability Ranking Index (HLSRI) |
| Machine learning | Random Forest, Gradient Boosting |
| FACTS devices | UPFC, IPFC |
| Optimization algorithms | SPBO, SSA |
| Implementation | MATLAB |

## Repository Structure

| Folder | Description |
|---|---|
| `IEEE30Bus/` | MATLAB scripts and data for the IEEE 30-bus system |
| `IEEE118Bus/` | MATLAB scripts and data for the IEEE 118-bus system |
| `OptimizationAlgorithms/` | Metaheuristic optimization algorithms (SPBO, SSA) |
| `docs/` | Project reports and research papers |

## How to Run

1. Open the project in MATLAB.
2. Load the required data from `IEEE30Bus/load_flow_data.mat` or `IEEE118Bus/load_flow_data.mat`.
3. Execute `ml_classification.m` to classify contingencies.
4. Run `ipfc_upfc_placement.m` for optimal FACTS device placement.

## Requirements

- MATLAB R2020a or higher
- Optimization Toolbox (listed as optional for SPBO/SSA)
- Machine Learning Toolbox

## Project Context

This was a final-year academic project. The repository documents the simulation systems, machine-learning methods, FACTS device placement, and optimization algorithms used in the work.

## License

This project is shared for educational purposes.
