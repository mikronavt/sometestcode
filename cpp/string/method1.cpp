#include <cstddef>
#include <cstring>

struct String {
    String(const char *str = "");
    String(size_t n, char c);
    ~String();

    size_t size() {
        // put your code here
		return this->size_;
    }

    char &at(size_t idx) {
		return this->str_[idx];
        // here
    }

    const char *c_str() {
		return this->str_;
        // and here
    }

    size_t size_;
    char *str_;
};

int main(){
	return 0;
}