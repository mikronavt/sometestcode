#include <cstddef>

// Параметры функции copy_n идут в следующем
// порядке:
//   1. целевой массив
//   2. массив источник
//   3. количество элементов, которые нужно
//      скопировать
//
// Вам нужно реализовать только функцию copy_n,
// чтобы ее можно было вызвать так, как показано
// в примере.

// put your code here

template <typename T, typename S>
void copy_n(T * target, S * source, size_t n){
	for(size_t i = 0; i < n; ++i){
		target[i] = (T) source[i];
	}
}

int main(){
	int ints[] = {1, 2, 3, 4};
	double doubles[4] = {};
	copy_n(doubles, ints, 4);
	//cout << doubles[3];
	return 0;
}