import pickle
import pandas as pd

patient_data = {
               "radius_mean": 15,
               "texture_mean": 10,
               "perimeter_mean": 120,
               "area_mean": 1050,
               "smoothness_mean": 0.25,
               "compactness_mean": 0.25,
               "concavity_mean": 0.3,
               "concave points_mean": 0.15,
               "symmetry_mean": 0.25,
               "fractal_dimension_mean": 0.08,
               "radius_se": 1.1,
               "texture_se": 0.95,
               "perimeter_se": 8.5,
               "area_se": 155,
               "smoothness_se": 0.005,
               "compactness_se": 0.05,
               "concavity_se": 0.05,
               "concave points_se": 0.02,
               "symmetry_se": 0.08,
               "fractal_dimension_se": 0.01,
               "radius_worst": 26,
               "texture_worst": 18,
               "perimeter_worst": 185,
               "area_worst": 2020,
               "smoothness_worst": 0.15,
               "compactness_worst": 0.65,
               "concavity_worst": 0.75,
               "concave points_worst": 0.35,
               "symmetry_worst": 0.45,
               "fractal_dimension_worst": 0.12
               }

def load_bin():
    with open("./code/model.bin", "rb") as f:
        model = pickle.load(f)
    with open("./code/scaler.bin", "rb") as f:
        scaler = pickle.load(f)

    return model, scaler

def predict(patient_data, model, scaler):
    patient_data = pd.DataFrame(patient_data, index = [0])

    X_scaled = scaler.transform(patient_data)
    model_prediction = model.predict(X_scaled)

    if model_prediction[0] == 0:
        diagnosis = 'benign'
    elif model_prediction[0] == 1:
        diagnosis = 'malignant'

    print(f"The patient's tumour is predicted to be {diagnosis}.")

if __name__ == "__main__":
    model, scaler = load_bin()
    predict(patient_data, model, scaler)