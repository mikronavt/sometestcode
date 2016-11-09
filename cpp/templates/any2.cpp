#include <iostream>
#include <typeinfo>
using namespace std;

struct ICloneable
{
	virtual ICloneable* clone() const = 0;
	virtual ~ICloneable() { }
};

// Шаблон ValueHolder с типовым параметром T,
// должен содержать одно открытое поле data_
// типа T.
//
// В шаблоне ValueHolder должен быть определен
// конструктор от одного параметра типа T,
// который инициализирует поле data_.
//
// Шаблон ValueHolder должен реализовывать
// интерфейс ICloneable, и возвращать указатель
// на копию объекта созданную в куче из метода
// clone.

template <typename T>
struct ValueHolder : ICloneable {
	public:
	T data_;
	
	explicit ValueHolder(const T& value = T()):data_(value){
	}
	
	ICloneable * clone() const{
		ValueHolder * vh = new ValueHolder(*this);
		return vh;
	}
};



class Any{
	public:
	ICloneable * vh;
	
	Any(){
		vh = 0;
	}
	
	template <typename T>
	Any(T const& t){
		vh = new ValueHolder<T>(t);//проверить по ссылке и по значению
	}
	
	~Any(){
		delete vh;
	}
	
	Any(const Any & a){
		vh = a.vh->clone();
	}
	
	template <typename T>
	Any& operator=(T const& t){
		delete vh;
		vh = new ValueHolder<T>(t);
		return *this;
	}
	
	Any& operator=(Any const& a){
		if(this!=&a){
			delete vh;
			vh = a.vh->clone();
		}
		return *this;
	}
	
	template <typename T>
	T * cast(){
		ValueHolder<T> * vh_cast = dynamic_cast<ValueHolder<T>*>(vh);
		if(vh_cast) {
			T * data = &(vh_cast->data_);
			return data;
		}
		else{
			return 0;
		}
	}
};


int main(){
	
	return 0;
}
