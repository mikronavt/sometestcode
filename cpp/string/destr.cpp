#include <cstddef>
#include <cstring>

struct String {
    String(const char *str = "");
    String(size_t n, char c);

    // для освобождения памяти не используйте free
    // иначе ваша программа может не пройти
    // тестирование
    ~String() {
		size_ = 0;
		delete [] str_;
        // put your code here
    }

    size_t size_;
    char *str_;
};

int main(){
return 0;
}