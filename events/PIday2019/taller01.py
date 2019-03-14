#*********************
#  Importar módulos 
#*********************
import matplotlib.pyplot as plt
import numpy as np
from keras.datasets import mnist
from keras.layers import Input, Dense, Conv2D, MaxPooling2D, Flatten, Activation, Dropout
from keras.models import Model
from keras.utils import to_categorical

#*********************
# Variables globales 
#*********************
num_classes = 10 # Núm. de clases o etiquetas diferentes
N_epochs = 2     # Num. de veces que utilizamos el conjunto de datos
batch_size = 64  # Núm. de imágenes que usamos para ajustar la red en cada paso

#************************************
# Cargar el conjunto de datos MNIST
#************************************

(x_train, y_train), (x_test, y_test) = mnist.load_data()
#- x_train: imágenes para que la red aprenda
#- y_train: etiqueta de cada imagen
#- x_test:  imágenes para probar la red
#- y_test:  etiqueta de cada imagen

# ¡¡ Es importante conocer como son los datos !!
#  por ej. ¿¿ Qué dimensiones tienen ??

N_train,W,H = x_train.shape
N_test, W,H  = x_test.shape

print("Dims. del conjunto de entrenamiento:",N_train, W, H)
print("Dims. del conjunto de prueba (test):",N_test,  W, H)

# También es importante preparar los datos para poder procesarlos:

# 1) Las imágenes deben tener 4 dimensiones: 
#     Núm.imagnes, Ancho(W), Alto(H), Profundidad de color (D)

D=1 #<- Las imagenes de este ejemplo son en 'escala de grises' 
x_input = x_train.reshape((N_train,W,H,D)) 

# 2) Las etiquetas (1,2,3....) deben tener formato 'one-hot'

y_1hot = to_categorical(y_train, num_classes=num_classes)

#***********************************
# Construcción de la red neuronal 
#***********************************

#-- Tamaño de los filtros de convolucion
N = 3
#-- Agrupamiento
S = 2
#-- Neuronas lineales para estimar la etiqueta
M = 32

#== Capa de entrada ================
x = Input(shape=(W,H,D))

#== Capa Convolucional =============
h1 = Conv2D(16, (N, N), activation='relu', padding='same')(x)
#== Capa de agrupamiento ===========
h2 = MaxPooling2D((S, S))(h1)
#== Capa Convolucional =============
h3 = Conv2D(32, (N, N), activation='relu', padding='same')(h2)
#== Capa de agrupamiento ===========
h4 = MaxPooling2D((S, S))(h3)
#== Capa Convolucional =============
h5 = Conv2D(64, (N, N), activation='relu', padding='same')(h4)
#== Capa de agrupamiento ===========
h6 = MaxPooling2D((S, S))(h5)
#== Combinar los pixels resultantes
h7 = Flatten()(h6)
h8 = Dense(M, activation='relu')(h7)

#== Producir una salida ============
yhat = Dense(num_classes, activation='softmax')(h8)

#*******************************
# Crear el 'objeto' CNN 
#  y añadir 
#  - mecánismo para optimizar
#  - funcion de pérdida
#*******************************
CNN = Model(x,yhat)
CNN.compile(optimizer='adam', loss='categorical_crossentropy')

#*********************
#  ¡¡ APRENDEMOS !!
#*********************

CNN.fit(x_input, y_1hot, epochs=N_epochs, batch_size=batch_size)

#************************************
#      ¿Qué tal ha funcionado?
#  ¿¿Qué hará con ejemplos nuevos??
#************************************

# Recordad que los datos deben tener 4 dims.
x_nuevos = x_test.reshape((N_test,W,H,D)) 

# Vamos a ver que dice la CNN sobre estos ejemplos:
prediccion_etiqueta = CNN.predict(x_nuevos)

# Pero...¿Qué tal funciona con la K-ésima imagen de prueba (test)?
k = 9999 #<-------- elegir un número entre 0 y 9999 !!
print(y_test[k] ,'<-- etiqueta real')
print(np.argmax(prediccion_etiqueta[k,:]) ,'<-- etiqueta predicha')
plt.imshow(x_test[k,:,:])
