#include <cstddef>

template <typename T>
class Array
{
    // Список операций:
    //
	public:
	
	
    Array(size_t size, const T& value = T()){
		size_ = size;
		data_ = (T*) (new char[size_ * sizeof(T)]);
		for(size_t i = 0; i < size; ++i){
			new (data_ + i) T(value);
		}
	}
    //   конструктор класса, который создает
    //   Array размера size, заполненный значениями
    //   value типа T. Считайте что у типа T есть
    //   конструктор, который можно вызвать без
    //   без параметров, либо он ему не нужен.
    //
    Array(){
		size_ = 0;
		data_ = (T*) (new char[size_ * sizeof(T)]) ;
	}
    //   конструктор класса, который можно вызвать
    //   без параметров. Должен создавать пустой
    //   Array.
    //
    Array(const Array & a): size_(a.size_), data_((T*) (new char[size_ * sizeof(T)])){
	
		for(size_t i = 0; i < size_; ++i){
			new (data_ + i) T(a.data_[i]);
		} 
	}
    //   конструктор копирования, который создает
    //   копию параметра. Для типа T оператор
    //   присвивания не определен.
    //
    ~Array(){
		operator delete[] (data_);
	}
    //   деструктор, если он вам необходим.
    //
    Array& operator=(Array const& a){
		if(data_!=a.data_){
			operator delete[] (data_);
			size_ = a.size_;
			data_ = (T*) (new char[size_ * sizeof(T)]);
			for(size_t i = 0; i < size_; ++i){
				new (data_ + i) T(a.data_[i]);
			}
		}
	}
    //   оператор присваивания.
    //
    size_t size() const{
		return size_;
	}
    //   возвращает размер массива (количество
    //                              элемнтов).
    //
    T& operator[](size_t i){
		return data_[i];
	}
    const T& operator[](size_t i) const{
		return data_[i];
	}
    //   две версии оператора доступа по индексу.
	
	private:
	size_t size_;
	T * data_;
};

int main(){
	return 0;
}