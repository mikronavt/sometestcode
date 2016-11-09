#include <cstddef>
#include <cstring>
#include <iostream>
using namespace std;

struct String {
    String(const char *str = "");
    String(size_t n, char c);
    ~String();

    size_t size();
    char &at(size_t idx);
    //const char *c_str();
	
	const char *c_str() {
		return this->str_;
        // and here
    }

    int compare(String &str) {
		
		const char *c = str.c_str();
		
		return strcmp(str_, c);
        // and here
    }

    size_t size_;
    char *str_;
};

int main(){
	
	return 0;
}