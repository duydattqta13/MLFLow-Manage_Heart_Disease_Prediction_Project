## Nội dung thực hiện
- [Slide](https://github.com/duydattqta13/MLFLow-Manage_Heart_Disease_Prediction_Project/blob/main/Slide_Presentation.pdf)
- [EDA dataset](https://github.com/duydattqta13/MLFLow-Manage_Heart_Disease_Prediction_Project/blob/main/EDA_Predict_Heart_Disease.ipynb)
- [Experiment Model](https://github.com/duydattqta13/MLFLow-Manage_Heart_Disease_Prediction_Project/blob/main/heart_prediction.py)

## Các models thực nghiệm
DecisionTreeClassifier, KNeighborsClassifier, LogisticRegression, RandomForestClassifier
## Virtual Environment
Tạo môi trường với Conda

```python
conda create -n mlflow-venv python=3.10
```

```python
conda activate mlflow-venv
```

```python
pip install mlflow
```

# Các chú ý khi dùng MLflow Tracking
`mlflow.set_tracking_uri()`: kết nối đến một tracking URI, thường sẽ thiết lập biến môi trường MLFLOW_TRACKING_URI. URI có thể là HTTP/HTTPS cho remote server, database connection string, hoặc local path để log data đến 1 đường dẫn. URI mặc định đến folder mlruns.

`mlflow.get_tracking_uri()`: trả về tracking URI hiện tại

`mlflow.create_experiment()`: Tạo thực nghiệm mới và trả ra ID của nó. Quá trình run có thể tiến hành bằng cách truyền experiment ID vào `mlflow.start_run`

`mlflow.log_param()`: log cặp key-value param trong quá trình chạy hiện tại, có thể sử dụng `mlflow.log_prams()` để log nhiều params.

`mlflow.log_metric()`: log cặp key-value metric.

#### Lưu ý: nếu chạy command mlflow ui và sau đó vào link 127.0.0.1:5000 bị lỗi thì fix như sau:
- Lấy danh sách các Services và PID running
`sudo lsof -i tcp:5000 `
- Kill mã PID của process đang tồn tại trước đó
`kill -15 <PID>`

# MLFlow Projects

- Tạo Run dùng MLFlow project file
`mlflow run . --experiment-name Heart_disease_prediction`  # run folder chỗ `MLProject` file hiện có

![result_1](result_1.png)
![result_2](result_2.png)

- Run từ git repository
`mlflow run https://github.com/manifoldailearning/ml-flow-project --experiment-name Heart_disease_prediction` 

# MLFlow Models
- install virtualenv
`pip install virtualenv`

- install chardet
`pip install chardet`

- Serve Models với Local REST server
`mlflow models serve -m runs:/11afa00e7dee42a19f0b19640180556c/DecisionTreeClassifier --host 127.0.0.1 --port 9000`

`mlflow models serve -m /Users/nachiketh/Desktop/author-repo/Complete-MLOps-BootCamp/MLFlow-Manage-ML-Experiments/mlruns/636758781795674813/91ef1ea3f63d40a7a33c4251dd088618/artifacts/RandomForestClassifier --port 9000`

# Generate Predictions
- http://127.0.0.1:9000/invocations

```json
{
    "dataframe_split": {
        "columns": [
            "ID","age","sex","chest","resting_blood_pressure","serum_cholestoral","fasting_blood_sugar","resting_electrocardiographic_results","maximum_heart_rate_achieved","exercise_induced_angina",
            "oldpeak","slope","number_of_major_vessels","thal"
        ],
        "data": [
            [
               600000,53.963191,1,4.0,136.940829,236.86281400000001,0,2,143.961525,1,0.7111,1,2,7
            ]
        ]
    }
}
```

# Curl

http://localhost:9000

```bash
curl --location 'http://127.0.0.1:9000/invocations' --header 'Content-Type: application/json' \
--data '{
    "dataframe_split": {
        "columns": [
            "ID","age","sex","chest","resting_blood_pressure","serum_cholestoral","fasting_blood_sugar","resting_electrocardiographic_results","maximum_heart_rate_achieved","exercise_induced_angina",
            "oldpeak","slope","number_of_major_vessels","thal"
        ],
        "data": [
            [
                600000,53.963191,1,4.0,136.940829,236.86281400000001,0,2,143.961525,1,0.7111,1,2,7
            ]
        ]
    }
}'
```
```yaml
LogisticRegression/
    - conda.yaml
    - MLmodel
    - model.pkl
    - requriments.txt
```

- Installation
`pip install mysqlclient`

-port 5001
`mlflow server --host 0.0.0.0 --port 5001 --backend-store-uri mysql://root:admin123@localhost/db_mlflow --default-artifact-root $PWD/mlruns`

- port 5000
`mlflow server --host 0.0.0.0 --port 5000 --backend-store-uri mysql://root:admin123@localhost/db_mlflow --default-artifact-root $PWD/mlruns`

`export MLFLOW_TRACKING_URI=http://0.0.0.0:5001`

`mlflow models serve -m "models:/Prediction_Model_RF/Production" -p 1234`
