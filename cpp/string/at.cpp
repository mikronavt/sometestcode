#include <cstddef>
#include <cstring>

struct String {
    String(const char *str = "");
    String(size_t n, char c);
    ~String();

    size_t size() const;
    const char *c_str() const;

    char & at(size_t idx);


    // подумайте какой должна быть сигнатура
    // метода at, и добавьте второй вариант
    // метода ниже (и реализуйте).

    // put your code here
	char & at(const size_t & idx) const{
		size_t a = idx;
		return this->str_[a];
	}

    int compare(const String &str) const;
    void append(const String &str);

    size_t size_;
    char *str_;
};

int main(){
	
	return 0;
}