#include <iostream>
#include <cstddef>

template <typename T>
class Array
{
public:
	explicit Array(size_t size = 0, const T& value = T());
	Array(const Array& other);
	~Array();
	Array& operator=(Array other);
	void swap(Array &other);
	size_t size() const;
	T& operator[](size_t idx);
	const T& operator[](size_t idx) const;

private:
	size_t size_;
	T *data_;
};

// Весь вывод должен осущствляться в поток out,
// переданный в качестве параметра.
//
// Можно заводить любые вспомогаетльные функции,
// структуры или даже изменять сигнатуру flatten,
// но при этом все примеры вызова из задания должны
// компилироваться и работать.

template <typename T>
void flatten(const T& t, std::ostream& out){
	out << t << " ";
}

template <typename T>
void flatten(const Array<T>& array, std::ostream& out)
{
	for(size_t i = 0; i < array.size(); ++i){
		flatten(array[i], out);
	}
}



int main(){
	Array<int> ints(2, 0);
	ints[0] = 10;
	ints[1] = 20;
	flatten(ints, std::cout); // выводит на экран строку "10 20"
	Array< Array<int> > array_of_ints(2, ints);
	flatten(array_of_ints, std::cout); // выводит на экран строку "10 20 10 20"
	Array<double> doubles(10, 0.0);
	flatten(doubles, std::cout); // работать должно не только для типа int
}