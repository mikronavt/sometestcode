// Определите шаблон SameType с двумя типовыми
// параметрами. В шаблоне должна быть определена
// одна статическая константа типа bool с именем
// value

template <class T, class V>
struct SameType{
	public:
	static const bool value = false;
	
};

template <class T>
struct SameType<T,T>{
	public:
	static const bool value = true;
};




int main(){
	return 0;
}