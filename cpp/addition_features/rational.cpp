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
	
	Rational & operator+=(Rational const& r){
		this->add(r);
		return *this;
	}
	
	/*Rational & operator+=(int i){
		this->add(Rational(i, 1));
		return *this;
	}*/
	
	Rational & operator-=(Rational const& r){
		this->sub(r);
		return * this;
	}
	/*
	Rational & operator-=(int i){
		this->sub(Rational(i, 1));
		return *this;
	}*/
	
	Rational & operator*=(Rational const& r){
		this->mul(r);
		return *this;
	}
	/*
	Rational & operator*=(int i){
		this->mul(Rational(i, 1));
		return *this;
	}*/
	
	Rational & operator/=(Rational const& r){
		this->div(r);
		return *this;
	}
	/*
	Rational & operator/=(int i){
		this->div(Rational(i, 1));
		return *this;
	}*/
	
	/*Rational operator+(Rational const& r){
		return *this+=r;
	}*/
	
	/*Rational operator+(int i){
		return *this+=i;
	}*/
	
	
	
	/*Rational operator-(Rational const& r){
		return *this-=r;
	} */
	
	/*Rational operator-(int i){
		return *this-=i;
	} */
	
	Rational operator-(){
		
		Rational r(this->numerator_, this->denominator_);
		r.neg();
		return r;
	}
	
	Rational operator+(){
		return Rational(this->numerator_, this->denominator_);
	}

private:
    int numerator_;
    unsigned denominator_;
};

int main(){
	//Rational r1(5,1);
	return 0;
}