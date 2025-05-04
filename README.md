# Enhancing Power System Security using Machine Learning and FACTS Devices

This repository contains the MATLAB code, simulation data, and results for my final year project:  
**"Enhancing Power System Security under Contingency using Machine Learning, FACTS Devices, and Nature-Inspired Optimization Techniques"**.

## Project Highlights
- Simulated **IEEE 30-bus** and **IEEE 118-bus** test systems
- Developed **Hybrid Line Stability Ranking Index (HLSRI)** for contingency analysis
- Implemented **Random Forest** and **Gradient Boosting** classifiers (95-96% accuracy)
- Optimized FACTS devices placement (**UPFC**, **IPFC**) using **Student Psychology Based Optimization (SPBO)**
- Achieved significant improvements in power loss reduction and voltage stability

## Folder Structure
- `/IEEE30Bus/` — MATLAB scripts and data for IEEE 30-bus system
- `/IEEE118Bus/` — MATLAB scripts and data for IEEE 118-bus system
- `/OptimizationAlgorithms/` — Metaheuristic algorithms (SPBO, etc.)
- `/docs/` — Project reports and research papers

## How to Run
1. Open MATLAB
2. Load the required data from `/IEEE30Bus/load_flow_data.mat` or `/IEEE118Bus/load_flow_data.mat`
3. Execute `ml_classification.m` to classify contingencies
4. Run `ipfc_upfc_placement.m` for optimal FACTS device placement

## Requirements
- MATLAB R2020a or higher
- Optimization Toolbox (optional for SPBO)
- Machine Learning Toolbox

## License
This project is open-source for educational purposes. 
