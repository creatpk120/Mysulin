package mysulin;

public class Bean_Schedule {

	private int    numb;
	private String chart_numb;
	private String chart_name;
	private String rx_code;
	private String rx_name;
	private int	   rx_amnt;
	private int	   rx_date;
	private String rx_next;
	private String note;
	private int	   st_amnt;

	public void setNumb(int numb)				 {this.numb = numb;}
	public void setChart_numb(String chart_numb) {this.chart_numb = chart_numb;}
	public void setChart_name(String chart_name) {this.chart_name = chart_name;}
	public void setRx_code(String rx_code)  	 {this.rx_code = rx_code;}
	public void setRx_name(String rx_name)  	 {this.rx_name = rx_name;}
	public void setRx_amnt(int rx_amnt)			 {this.rx_amnt = rx_amnt;}
	public void setRx_date(int rx_date)			 {this.rx_date = rx_date;}
	public void setRx_next(String rx_next)		 {this.rx_next = rx_next;}
	public void setNote(String note)			 {this.note = note;}
	public void setSt_amnt(int st_amnt)			 {this.st_amnt = st_amnt;}
	
	public int getNumb()		  {return numb;}
	public String getChart_numb() {return chart_numb;}
	public String getChart_name() {return chart_name;}
	public String getRx_code()	  {return rx_code;}
	public String getRx_name()	  {return rx_name;}
	public int getRx_amnt()		  {return rx_amnt;}
	public int getRx_date()		  {return rx_date;}
	public String getRx_next()	  {return rx_next;}
	public String getNote()		  {return note;}
	public int getSt_amnt()		  {return st_amnt;}
}