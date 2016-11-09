#include <iostream>
#include <typeinfo>
using namespace std;

int memory = 0;

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

// Это класс, который вам нужно реализовать
class Any
{
	public:
	
	
	ICloneable * vh;
    // В классе Any должен быть конструктор,
    // который можно вызвать без параметров,
    // чтобы работал следующий код:
    //    Any empty; // empty ничего не хранит
	
	
	Any(){
		memory++;
		vh = 0;
		//cout<< "vh = "<< vh << endl;
	}

    // В классе Any должен быть шаблонный
    // конструктор от одного параметра, чтобы
    // можно было создавать объекты типа Any,
    // например, следующим образом:
    //    Any i(10); // i хранит значение 10
	template <typename T>
	Any(T const& t){
		memory++;
		vh = new ValueHolder<T>(t);
		//cout<< "vh = "<< vh << endl;;
	}

    // Не забудьте про деструктор. Все выделенные
    // ресурсы нужно освободить.
	~Any(){
		memory--;
		delete vh;
		//cout<< "vh = "<< vh << endl;
	}

    // В классе Any также должен быть конструктор
    // копирования (вам поможет метод clone
    // интерфейса ICloneable)
	Any(const Any & a){
		memory++;
		vh = a.vh->clone();
		//cout<< "vh = "<< vh << endl;
	
	}

    // В классе должен быть оператор присваивания и/или
    // шаблонный оператор присваивания, чтобы работал
    // следующий код:
    //    Any copy(i); // copy хранит 10, как и i
    //    empty = copy; // empty хранит 10, как и copy
    //    empty = 0; // а теперь empty хранит 0
	
	/*template <typename T>
	Any& operator=(T const& t){
		cout << ((dynamic_cast<ValueHolder<T>*>(vh))->data_ )<< endl;
		cout << t << endl;
		if((dynamic_cast<ValueHolder<T>*>(vh))->data_!=t){
			memory--;
			delete vh;
			memory++;
			vh = new ValueHolder<T>(t);
		}
		
		return *this;
	} */
	
	template <typename T>
	Any& operator=(T const& t){
		if((dynamic_cast<ValueHolder<T>*>(vh).data_)!=t){
			delete vh;
			
			vh = new ValueHolder<T>(t);
			
			
		}
	}

	//template <typename T>
	/*Any& operator=(Any const& a){
		cout << "operator =" << endl;
		if(this!=&a){
			delete vh;
			
			vh = a.vh->clone();
			
		}
		return *this;
		/*if(vh!=a.vh){
			cout << "vh!=a.vh" << endl;
			if(vh!=0) {
				cout << "vh!=0 ... deleting" << endl;
				delete vh;
			}
			if(&a==0){
				cout << "a == 0";
				vh = 0;
			}
			if(a.vh!=0){
				cout << "a.vh!=0 ... cloning" << endl;
				vh = a.vh->clone();
				cout << "cloned" << endl;
			}
			else{
				cout << "vh =0" << endl;
				vh = 0;
			}
		}*/
	//}
	
	
    // Ну и наконец, мы хотим уметь получать хранимое
    // значение, для этого определите в классе Any
    // шаблонный метод cast, который возвращает
    // указатель на хранимое значение, или нулевой
    // указатель в случае несоответствия типов или
    // если объект Any ничего не хранит:
    //    int *iptr = i.cast<int>(); // *iptr == 10
    //    char *cptr = i.cast<char>(); // cptr == 0,
    //        // потому что i хранит int, а не char
    //    Any empty2;
    //    int *p = empty2.cast<int>(); // p == 0
    // При реализации используйте dynamic_cast,
    // который мы уже обсуждали ранее.
	template <typename T>
	T * cast(){
		
			//cout << "cast started";
			//if(vh != 0) {
			//cout << "return not 0";
			//return 0; 
			//}
			ValueHolder<T> * vh_cast = dynamic_cast<ValueHolder<T>*>(vh);
			//cout<<"vh_cast done";
			if(vh_cast) {
					//cout << "vh_cast no null";
					//T cast = const_cast<T>(vh_cast->data_);
					T * data = &(vh_cast->data_);
					//cout<<"data done";
					//T * data_cast = dynamic_cast<T*>(data);
					return data;
				
			}
			
			return 0;
		
	}
};

int main(){
	cout << "Any empty" << endl;
	Any empty;
	cout << "Any i(10)" << endl;
    Any i(10);
	cout << "cout i.cast<int>()" << endl;
    cout << "[1] i=" << i.cast<int>() << endl;
	cout << "Any copy(i)"<< endl;
    Any copy(i);
	cout << "cout copy.cast<int>()" << endl;
    cout << "[2] copy=" << copy.cast<int>() << endl;
	cout << "empty = copy" << endl;
    empty = copy;
	cout << "cout empty.cast<int>()" << endl; 
    cout << "[3] empty=" << empty.cast<int>() << endl;
	cout << "empty = 0" << endl;
    empty = 0;
	cout << "cout empty.cast<int>()" << endl;
    cout << "[4] empty=" << empty.cast<int>() << endl;
    int *iptr = i.cast<int>();
    cout << "[5] *iptr=" << iptr << endl;
    char *cptr = i.cast<char>();
    //cout << "[6] *cptr=" << cptr << endl;
    Any empty2;
    int *p = empty2.cast<int>();
    cout << "[7] *p=" << p << endl;
    Any a = 20;
    cout << "[8] a=" << a.cast<int>() << endl;
    a=0;
    cout << "[9] a=" << a.cast<int>() << endl;
	cout << "a = 'w'" << endl;
	cout << memory;
	a='w';
	
	cout << "cout a.cast<char>()" << endl;
	cout << "[10] a=" << a.cast<char>() << endl;
	return 0;
}