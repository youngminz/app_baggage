import coremltools as ct
import tensorflow as tf

# 모델 경로 로드
model_path = "converted_keras/keras_model.h5"
keras_model = tf.keras.models.load_model(model_path)

# 이미지 입력 설정
image_input = ct.ImageType(shape=(1, 224, 224, 3), scale=1/255.0)

# 라벨 파일에서 라벨 로드
label_path = "converted_keras/labels.txt"
with open(label_path, "r") as label_file:
    labels = label_file.read().splitlines()

# 라벨 리스트 생성 (라벨 파일의 각 줄에 대해)
class_labels = [label.split()[1] for label in labels]

# Core ML 모델로 변환, 이 때 image_input을 입력으로 사용하고, ClassifierConfig를 통해 라벨을 설정
model = ct.convert(
    keras_model, 
    inputs=[image_input], 
    classifier_config=ct.ClassifierConfig(class_labels),
    convert_to='mlprogram'
)

# 변환된 모델 저장
model.save("../Baggage/BaggageClassifier.mlpackage")
