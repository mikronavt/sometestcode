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

int main()
{
	return 0;
}