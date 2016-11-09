#include <cstddef>
#include <cstring>


struct String {
    String(const char *str = "");
    String(size_t n, char c);
    ~String();

    size_t size();
    char &at(size_t idx);
    const char *c_str();
    int compare(String &str);

    // для выделенеия и освобождения не используйте
    // malloc/free, иначе ваша программа может не
    // пройти тестирование
    void append(String &str) {
		const char * st = str.c_str();
		size_t add_size = str.size();
		this -> size_ = this -> size_ + add_size;
		char * tmp_str = new char[this->size_ + 1];
		strcpy(tmp_str, this-> str_);
		strncat(tmp_str , st, this->size_);
		delete [] str_;
		str_ = new char[this-> size_ + 1];
		strcpy(this-> str_, tmp_str);
		delete[] tmp_str;
		
		
        // put your code here
    }

    size_t size_;
    char *str_;
};

int main(){
return 0;
}