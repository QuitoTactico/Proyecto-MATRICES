--Si REPLIT se cayó, correrlo en https://paiza.io/projects/HbjQ9WqzUyxG8qiAP5I9Zw
import Data.Array     --importamos lo necesario
                      --las listas default no dan
type Matriz a = Array (Int,Int) a

  --Pasa del formato [[9,7,1],[4,7,8]] , al
  --[((1,1),9),((1,2),7),((1,3),1),((2,1),4),((2,2),7),((2,3),8)]
listaAPos :: Num a => [[a]] -> Matriz a
listaAPos xss = listArray ((1,1),(m,n)) (concat xss)
  where m = length xss
        n = length (head xss)

  --No se puede con length, toca hacerlo a mano,
  --Como todo...
numColumnas :: Num a => Matriz a -> Int
numColumnas = snd . snd . bounds

  --Array ya separa las cosas verticalmente (entre listas)
  --este sirve para lo horizontal (entre los elementos de cada una)
separa :: Int -> [a] -> [[a]]
separa _ [] = []
separa n xs = take n xs : separa n (drop n xs)

  --Pasa los valores de las posiciones del formato pos a un array normalito
posALista :: Num a => Matriz a -> [[a]]
posALista p = separa (numColumnas p) (elems p)


--                LAS OPERACIONES
--        (irónicamente, lo más sencillo)

--Son literalmente lo mismo, vuelve pares a los valores que tengan
--la misma pos, y los "une" usando el operador que queramos.
--el resultado de la operación va a quedar en esa pos, y luego
--lo volvemos a pasar a lista normalita 
--(bueno, Array, las listas normales no sirven pa na')


sumaM :: Num a => Matriz a -> Matriz a -> Matriz a
sumaM posM1 posM2 = 
  listArray (bounds posM1) (zipWith (+) (elems posM1) (elems posM2))

restaM :: Num a => Matriz a -> Matriz a -> Matriz a
restaM posM1 posM2 = 
  listArray (bounds posM1) (zipWith (-) (elems posM1) (elems posM2))

multipM :: Num a => Matriz a -> Matriz a -> Matriz a
multipM posM1 posM2 = 
  listArray (bounds posM1) (zipWith (*) (elems posM1) (elems posM2))

--No se le puede mandar el operador en string como hicimos en c++  :(

  --               BASTA DE CHÁCHARA


main = do
  
  --ESCRIBE AQUÍ LOS NÚMEROS DE TU MATRIZ c:
  --    PUEDE SER DE CUALQUIER DIMENSIÓN.
  --                   |  |  |  |  |  |  
  --                   V  V  V  V  V  V

  let m1 = listaAPos [[5,8,8,5],[1,3,2,6]]
  let m2 = listaAPos [[4,6,3,9],[1,7,5,9]]

  putStrLn "-> SUMA:"
  print(posALista (sumaM m1 m2))
  putStrLn "\n-> RESTA:"
  print(posALista (restaM m1 m2))
  putStrLn "\n-> MULTIPLICACIÓN:"
  print(posALista (multipM m1 m2))
