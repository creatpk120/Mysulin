package mysulin;


public class Bean_Order {
	
	private int    numb;
	private String order_usid;
	private String order_date;
	private String order_agnt;
	private String order_code;
	private String order_name;
	private int    order_pack;
	private String order_note;
	
	public void setNumb(int numb)	   			   {this.numb = numb;}
	public void setOrder_usid(String order_usid)   {this.order_usid = order_usid;}
	public void setOrder_date(String order_date)   {this.order_date = order_date;}
	public void setOrder_agnt(String order_agnt)   {this.order_agnt = order_agnt;}
	public void setOrder_code(String order_code)   {this.order_code = order_code;}
	public void setOrder_name(String order_name)   {this.order_name = order_name;}
	public void setOrder_pack(int order_pack)	   {this.order_pack = order_pack;}
	public void setOrder_note(String order_note)   {this.order_note = order_note;}
	
	public int getNumb()		   {return numb;}
	public String getOrder_usid()  {return order_usid;}
	public String getOrder_date()  {return order_date;}
	public String getOrder_agnt()  {return order_agnt;}
	public String getOrder_code()  {return order_code;}
	public String getOrder_name()  {return order_name;}
	public int getOrder_pack() 	   {return order_pack;}
	public String getOrder_note()  {return order_note;}

}
