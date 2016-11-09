#include <cstddef> // size_t
#include <iostream>

using namespace std;
// реализуйте шаблонную функцию array_size,
// которая возвращает значение типа size_t.

// put your code here
template <class T, size_t N>
size_t array_size(T (&t)[N]){
	return N;
}

int main(){
	int ints[] = {1, 2, 3, 4};
	cout<<array_size(ints);
	int *iptr = int;
	array_size(iptr);
	return 0;
}
