import mlflow
mlflow.set_tracking_uri("http://127.0.0.1:5000")
mlflow.sklearn.autolog()
logged_model = 'runs:/71355a151fa842b09dce6da501937bee/DecisionTreeClassifier'

# Load model as a PyFuncModel.
loaded_model = mlflow.pyfunc.load_model(logged_model)

# Predict on a Pandas DataFrame.
import pandas as pd
data = [[600000,53.963191,1,4.0,136.940829,236.86281400000001,0,2,143.961525,1,0.7111,1,2,7]]
print(f"Prediction is : {loaded_model.predict(pd.DataFrame(data))}")