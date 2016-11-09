struct Rational
{
    Rational(int numerator = 0, int denominator = 1);

    void add(Rational rational);
    void sub(Rational rational);
    void mul(Rational rational);
    void div(Rational rational);

    void neg();
    void inv();
    double to_double() const;
	
	operator double() const{
		return this->to_double();
	}

private:
    int numerator_;
    unsigned denominator_;
};


int main(){
return 0;
}