#include <cstddef> // size_t
#include <cstring> // strlen, strcpy
#include <iostream>
#define _CRT_SECURE_NO_WARNINGS
using namespace std;


struct String {
    // для аллокации памяти не используйте malloc
    // иначе ваша программа может не пройти
    // тестирование
    String(const char *str = "") {
        // put your code here
		size_ = strlen(str);
		str_ = new char[size_ + 1];
		strcpy(str_, str);

		
		
		cout<< this->str_;
    }
	
		char & at(size_t idx){
		size_t a = idx;
		if(a < 0 || a > this->size_) return str_[size_];
		cout << "not const";
		return this->str_[a];
		
	}
	
		char at(size_t idx) const{
		size_t a = idx;
		if(a < 0 || a > this->size_) return str_[size_];
		cout << "const";
		return this->str_[a];
	}

    // не изменяйте эти имена, иначе ваша программа
    // не пройдет тестирование
    size_t size_;
    char *str_;
};

int main(){
	
	String greet("Hello");
	char ch1 = greet.at(0);

	String const const_greet("Hello, Const!");
	char const &ch2 = const_greet.at(0);
	
	
	
	return 0;
}

