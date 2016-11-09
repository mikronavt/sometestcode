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

// put your code here
bool less(int a, int b) { return a < b; }
struct Greater { bool operator()(int a, int b) { return b < a; } };

template <typename T, typename C>
T minimum(Array<T> arr, C compare){
	T min = arr[0];
	for(size_t i = 0; i < arr.size(); i++){
		if(!compare(min, arr[i])) min = arr[i];
	}
	return min;
} 
	
int main(){

	Array<int> ints(3);
	ints[0] = 10;
	ints[1] = 2;
	ints[2] = 15;
	int min = minimum(ints, less); 
	int max = minimum(ints, Greater());
	return 0;
}