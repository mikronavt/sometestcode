#include <cstddef>
#include <cstring>

struct String {
    String(const char *str = "");

    // для аллокации памяти не используйте malloc
    // иначе ваша программа может не пройти
    // тестирование

    // заполните строку n повторениями символа c,
    // например, для n == 3 и c == 'a', в строке
    // должно быть "aaa" (и не забудьте про
    // завершающий нулевой символ)
    // n == 0 допустимое значение
    String(size_t n, char c) {
        // put your code here
		this->size_ = n;
		this->str_ = new char[n + 1];
		for(int i = 0; i<n; i++){
			this->str_[i] = c;
		}
		this->str_[n] = '\0';
    }

    // не изменяйте эти имена, иначе ваша программа
    // не пройдет тестирование
    size_t size_;
    char *str_;
};