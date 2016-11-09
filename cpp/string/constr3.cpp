#include <cstddef>
#include <cstring>

struct String {
    String(const char *str = "");
    String(size_t n, char c);
    ~String();

    String(const String &str) {
        // put your code here
		this->size_ = str.size();
		this->str_ = new char[this->size_ + 1];
		const char * c_str = str.c_str();
		strcpy(this->str_, c_str);
    }

    size_t size() const;
    const char *c_str() const;
    char & at(size_t idx);
    char at(size_t idx) const;
    int compare(const String &str) const;

    void append(const String &str);

    size_t size_;
    char *str_;
};

int main(){
	return 0;
}