package mysulin;

public class Bean_Mng_c {

	private int    numb;
	private String m_usid;
	private String m_y_date;
	private String m_t_date;
	private String m_check;

	public void setNumb(int numb) 		   	 {this.numb = numb;}
	public void setM_usid(String m_usid)   	 {this.m_usid = m_usid;}
	public void setM_y_date(String m_y_date) {this.m_y_date = m_y_date;}
	public void setM_t_date(String m_t_date) {this.m_t_date = m_t_date;}
	public void setM_check(String m_check) 	 {this.m_check = m_check;}
	
	public int getNumb() 	    {return numb;}
	public String getM_usid()   {return m_usid;}
	public String getM_y_date() {return m_y_date;}
	public String getM_t_date() {return m_t_date;}
	public String getM_check()  {return m_check;}
}