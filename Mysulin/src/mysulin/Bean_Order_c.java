package mysulin;

public class Bean_Order_c {

	private int    numb;
	private String o_usid;
	private String o_y_date;
	private String o_t_date;
	private String o_check;

	public void setNumb(int numb) 		   	 {this.numb = numb;}
	public void setO_usid(String o_usid)   	 {this.o_usid = o_usid;}
	public void setO_y_date(String o_y_date) {this.o_y_date = o_y_date;}
	public void setO_t_date(String o_t_date) {this.o_t_date = o_t_date;}
	public void setO_check(String o_check) 	 {this.o_check = o_check;}
	
	public int getNumb() 	    {return numb;}
	public String getO_usid()   {return o_usid;}
	public String getO_y_date() {return o_y_date;}
	public String getO_t_date() {return o_t_date;}
	public String getO_check()  {return o_check;}
}