#include <cstddef>

template <typename T>
class Array
{
    // Список операций:
    //
	public:
    explicit Array(size_t size = 0, const T& value = T()){
		size_ = size;
		data_ = new T[size];
		for(size_t i = 0; i < size; ++i){
			data_[i] = value;
		}
	}
    //   конструктор класса, который создает
    //   Array размера size, заполненный значениями
    //   value типа T. Считайте что у типа T есть
    //   конструктор, который можно вызвать без
    //   без параметров, либо он ему не нужен.
    //
    Array(const Array & a) : size_(a.size_), data_(new T[size_]){
		for(size_t i = 0; i < size_; ++i){
			data_[i] = a.data_[i];
		}
	}
	
	
    //   конструктор копирования, который создает
    //   копию параметра. Считайте, что для типа
    //   T определен оператор присваивания.
    //
    ~Array(){
		delete[] data_;
	}
    //   деструктор, если он вам необходим.
    //
    Array& operator=(Array const& a){
		if(data_!=a.data_){
			delete[] data_;
			size_ = a.size_;
			data_ = new T[size_];
			for(size_t i = 0; i < size_; ++i){
				data_[i] = a.data_[i];
			}
		}
	}
	
	Array& operator=(T * t){
		if(data_ != t){
			
			
		}
	}
    //   оператор присваивания.
    //
    size_t size() const{
		return size_;
	}
    //   возвращает размер массива (количество
    //                              элементов).
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
	
	Array<int> ai(10, 5);
	Array<long unsigned int> al(30, 3);
	Array<int> aii = ai;
	
	return 0;
	
}