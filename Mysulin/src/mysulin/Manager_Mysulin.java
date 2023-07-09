package mysulin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class Manager_Mysulin {

	private DBConnectionMgr pool;

	public Manager_Mysulin() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 홈페이지 공통 정보 ===========================================
	// 로그인
	public boolean loginMember(String usid, String uspw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select usid from admin where usid = ? and uspw = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			pstmt.setString(2, uspw);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 회원 정보 ===============================================================================
	// ID 중복 체크
	public boolean checkId(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select usid from admin where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 우편번호 찾기
	public Vector<Bean_Postcode> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Postcode> vlist = new Vector<Bean_Postcode>();
		try {
			con = pool.getConnection();
			sql = "select * from post where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + area3 + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Postcode bean = new Bean_Postcode();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 회원 추가
	public boolean insertMember(Bean_Admin bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert admin(usid,uspw,auth,name,telp,phone,gend,brth,mail,post"
					+ ",addr,hobb)values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsid());
			pstmt.setString(2, bean.getUspw());
			pstmt.setString(3, bean.getAuth());
			pstmt.setString(4, bean.getName());
			pstmt.setString(5, bean.getTelp());
			pstmt.setString(6, bean.getPhone());
			pstmt.setString(7, bean.getGend());
			pstmt.setString(8, bean.getBrth());
			pstmt.setString(9, bean.getMail());
			pstmt.setString(10, bean.getPost());
			pstmt.setString(11, bean.getAddr());
			String hobby[] = bean.getHobb();
			char hb[] = { '0', '0', '0', '0', '0' };
			String lists[] = { "독서", "등산", "낚시", "여행", "영화" };
			for (int i = 0; i < hobby.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if (hobby[i].equals(lists[j]))
						hb[j] = '1';
				}
			}
			pstmt.setString(12, new String(hb));
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 회원 조회 (usid)
	public Bean_Admin getMember(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Admin bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from admin where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Admin();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setAuth(rs.getString("auth"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setPhone(rs.getString("phone"));
				bean.setGend(rs.getString("gend"));
				bean.setBrth(rs.getString("brth"));
				bean.setMail(rs.getString("mail"));
				bean.setPost(rs.getString("post"));
				bean.setAddr(rs.getString("addr"));
				String hobbys[] = new String[5];
				String hobb = rs.getString("hobb");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobb.substring(i, i + 1);
				}
				bean.setHobb(hobbys);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 회원 조회 (numb)
	public Bean_Admin getMember2(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Admin bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from admin where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Admin();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setAuth(rs.getString("auth"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setPhone(rs.getString("phone"));
				bean.setGend(rs.getString("gend"));
				bean.setBrth(rs.getString("brth"));
				bean.setMail(rs.getString("mail"));
				bean.setPost(rs.getString("post"));
				bean.setAddr(rs.getString("addr"));
				String hobbys[] = new String[5];
				String hobb = rs.getString("hobb");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobb.substring(i, i + 1);
				}
				bean.setHobb(hobbys);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 회원 조회 (numb)
	public Bean_Admin getMember3(String usid, int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Admin bean = null;
		try {
			con = pool.getConnection();
			if (numb > 0) {
				String sql = "select * from admin where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
			} else {
				String sql = "select * from admin where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);
			}
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Admin();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setAuth(rs.getString("auth"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setPhone(rs.getString("phone"));
				bean.setGend(rs.getString("gend"));
				bean.setBrth(rs.getString("brth"));
				bean.setMail(rs.getString("mail"));
				bean.setPost(rs.getString("post"));
				bean.setAddr(rs.getString("addr"));
				String hobbys[] = new String[5];
				String hobb = rs.getString("hobb");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobb.substring(i, i + 1);
				}
				bean.setHobb(hobbys);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 회원 정보 수정
	public boolean updateMember(Bean_Admin bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update admin set uspw=?, auth=?, name=?, telp=?, phone=?, gend=?,"
					+ "brth=?, mail=?, post=?, addr=?, hobb=? where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUspw());
			pstmt.setString(2, bean.getAuth());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getTelp());
			pstmt.setString(5, bean.getPhone());
			pstmt.setString(6, bean.getGend());
			pstmt.setString(7, bean.getBrth());
			pstmt.setString(8, bean.getMail());
			pstmt.setString(9, bean.getPost());
			pstmt.setString(10, bean.getAddr());
			char hobby[] = { '0', '0', '0', '0', '0' };
			if (bean.getHobb() != null) {
				String hobbys[] = bean.getHobb();
				String lists[] = { "독서", "등산", "낚시", "여행", "영화" };
				for (int i = 0; i < hobbys.length; i++) {
					for (int j = 0; j < lists.length; j++)
						if (hobbys[i].equals(lists[j]))
							hobby[j] = '1';
				}
			}
			pstmt.setString(11, new String(hobby));
			pstmt.setString(12, bean.getUsid());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 회원 총 수
	public int getTotalCount(String check) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
	
		try {
			con = pool.getConnection();
			if ( check.equals("S") ) {
				sql = "select count(numb) from admin ";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("A") ) {
				sql = "select count(numb) from admin where auth='A' ";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("B") ) {
				sql = "select count(numb) from admin where auth='B' ";
				pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 해당 조건의 회원 조회
	public Vector<Bean_Admin> getMemberList(String check) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Admin> vlist = new Vector<Bean_Admin>();
		//System.out.println(check);
		try {
			con = pool.getConnection();
			if ( check.equals("S") ) {
				sql = "select * from admin ";
			   	pstmt = con.prepareStatement(sql);
			} else if ( check.equals("A") ) {
				sql = "select * from admin where auth='A' ";
			   	pstmt = con.prepareStatement(sql);
			} else if ( check.equals("B") ) {
				sql = "select * from admin where auth='B' ";
			   	pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Admin bean = new Bean_Admin();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setAuth(rs.getString("auth"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setPhone(rs.getString("phone"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 회원 정보 삭제
	public void deleteMember(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from admin where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	// 회원 권한 클릭으로 단계별 변경
	public boolean updatePerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("B")) {
				String sql = "update admin set auth='A' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else if (perm.equals("A")) {
				String sql = "update admin set auth='S' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else if (perm.equals("S")) {
				String sql = "update admin set auth='B' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	// 코드 정보 ===============================================================================
	// 코드 내역 해당 조건으로 조회
	public Vector<Bean_Code> getCodeList(String check) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Code> vlist = new Vector<Bean_Code>();
		try {
			con = pool.getConnection();
			if (check.equals("B2")) {
				sql = "select * from code where substr(code,2,1)='2' ";
			    pstmt = con.prepareStatement(sql);
			} else if (check.equals("B3")) {
				sql = "select * from code where substr(code,2,1)='3' ";
			    pstmt = con.prepareStatement(sql);
			} else if (check.equals("B5")) {
				sql = "select * from code where substr(code,2,1)='5' ";
			    pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Code bean = new Bean_Code();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setAgnt(rs.getString("agnt"));
				bean.setCode(rs.getString("code"));
				bean.setName(rs.getString("name"));
				bean.setNote(rs.getString("note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 코드 내역 신규 추가
	public boolean Code_Insert(Bean_Code bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert code(usid,agnt,code,name,note) values (?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsid());
			pstmt.setString(2, bean.getAgnt());
			pstmt.setString(3, bean.getCode());
			pstmt.setString(4, bean.getName());
			pstmt.setString(5, bean.getNote());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 코드 자료 수(수정?)
	public int getCodeCount(String check, String keyWord, String keyField, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (check.equals("S") | check.equals("A")) {
				sql = "select count(numb) from code ";
			    pstmt = con.prepareStatement(sql);
			} else if (check.equals("B")) {
				sql = "select count(numb) from code where "  + keyField + " like ? ";
			    pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 코드 내역 아이디 조건으로 조회(수정?)
	public Vector<Bean_Code> getCodeList(String check, String keyWord, String keyField, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Code> vlist = new Vector<Bean_Code>();
		try {
			con = pool.getConnection();
			if (check.equals("S")) {
				sql = "select * from code ";
			    pstmt = con.prepareStatement(sql);
			} else if (check.equals("A")) {
				sql = "select * from code ";
				//sql = "select * from code where usid=? ";
			    pstmt = con.prepareStatement(sql);
				//pstmt.setString(1, usid);
			} else if (check.equals("B")) {
				sql = "select * from code where "  + keyField + " like ? ";
			    pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Code bean = new Bean_Code();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setAgnt(rs.getString("agnt"));
				bean.setCode(rs.getString("code"));
				bean.setName(rs.getString("name"));
				bean.setNote(rs.getString("note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 코드 내역 아이디 조건으로 조회(수정?)
	public Vector<Bean_Code> getCodeList1(String usid) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	Vector<Bean_Code> vlist = new Vector<Bean_Code>();
	try {
		con = pool.getConnection();
		sql = "select * from code ";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			Bean_Code bean = new Bean_Code();
			bean.setNumb(rs.getInt("numb"));
			bean.setUsid(rs.getString("usid"));
			bean.setAgnt(rs.getString("agnt"));
			bean.setCode(rs.getString("code"));
			bean.setName(rs.getString("name"));
			bean.setNote(rs.getString("note"));
			vlist.add(bean);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(con, pstmt, rs);
	}
	return vlist;
}

	// 코드 등록 내역 조회 (numb)
	public Bean_Code getCode1(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Code bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from code where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Code();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setAgnt(rs.getString("agnt"));
				bean.setCode(rs.getString("code"));
				bean.setName(rs.getString("name"));
				bean.setNote(rs.getString("note"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 코드 내역 수정
	public boolean updateCode(Bean_Code bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update code set usid=?, agnt=?, code=?, name=?, note=? where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsid());
			pstmt.setString(2, bean.getAgnt());
			pstmt.setString(3, bean.getCode());
			pstmt.setString(4, bean.getName());
			pstmt.setString(5, bean.getNote());
			pstmt.setInt(6, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 코드 정보 삭제
	public void deleteCode(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from code where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 코드 내역 아이디 조건으로 조회
	public Vector<Bean_Code> getKeyWord(String keyField, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Code> vlist = new Vector<Bean_Code>();
		try {
			con = pool.getConnection();
			if (keyField.equals("B2")) {
				sql = "select * from code where substr(code,2,1)='2' ";
			    pstmt = con.prepareStatement(sql);
			} else if (keyField.equals("B3")) {
				sql = "select * from code where substr(code,2,1)='3' ";
			    pstmt = con.prepareStatement(sql);
			} else if (keyField.equals("B5")) {
				sql = "select * from code where substr(code,2,1)='5' ";
			    pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Code bean = new Bean_Code();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setAgnt(rs.getString("agnt"));
				bean.setCode(rs.getString("code"));
				bean.setName(rs.getString("name"));
				bean.setNote(rs.getString("note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}


	// 재고 자료 ===============================================================================
	// 재고 자료 신규 추가
	public boolean Stock_Insert(Bean_Stock bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert stock(stock_usid, stock_date, stock_code, stock_name, stock_exp,"
				+ "stock_pack, stock_piece, stock_total, stock_note) "
				+ "values (?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getStock_usid());
			pstmt.setString(2, bean.getStock_date());
			pstmt.setString(3, bean.getStock_code());
			pstmt.setString(4, bean.getStock_name());
			pstmt.setString(5, bean.getStock_exp());
			pstmt.setInt(6, bean.getStock_pack());
			pstmt.setInt(7, bean.getStock_piece());
			pstmt.setInt(8, bean.getStock_total());
			pstmt.setString(9, bean.getStock_note());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
	
	// 재고 자료  조회
	public Vector<Bean_Stock> getStockList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock> vlist = new Vector<Bean_Stock>();
		try {
			con = pool.getConnection();
			sql = "select * from stock";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock bean = new Bean_Stock();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 재고 자료  조회
	public Vector<Bean_Stock> getStockList2() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock> vlist = new Vector<Bean_Stock>();
		try {
			con = pool.getConnection();
			sql = "select * from stock";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock bean = new Bean_Stock();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	// 재고 자료  조회(뭐임??)
	public Vector<Bean_Stock_l> getStockLList2(String stock_date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock_l> vlist = new Vector<Bean_Stock_l>();
		try {
			con = pool.getConnection();
			sql = "select * from stock";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock_l bean = new Bean_Stock_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	// 재고 자료  조회
	public Vector<Bean_Stock> getStockList1(String code, String name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock> vlist = new Vector<Bean_Stock>();
		try {
			con = pool.getConnection();
			sql = "select * from stock where stock_code=? and stock_name=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.setString(2, name);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock bean = new Bean_Stock();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	// 재고 자료 수(수정??? 카운트가 제일 어렵다)
	public int getStockCount(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(numb) from stock ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 재고 자료 수정을 위해 자료 가져오기
	public Bean_Stock getStock(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Stock bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from stock where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Stock();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 재고 자료 코드 가져오기(뭐지? code, usid 세트였는데 후자는 지움)
	public Bean_Stock getStock_code(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Stock bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from stock where stock_usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Stock();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 재고 자료 수정
	public boolean updateStock(Bean_Stock bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update stock set stock_usid=?, stock_date=?, stock_code=?, stock_name=?, stock_exp=?,"
				+ "stock_pack=?, stock_piece=?, stock_total=?, stock_note=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getStock_usid());
			pstmt.setString(2, bean.getStock_date());
			pstmt.setString(3, bean.getStock_code());
			pstmt.setString(4, bean.getStock_name());
			pstmt.setString(5, bean.getStock_exp());
			pstmt.setInt(6, bean.getStock_pack());
			pstmt.setInt(7, bean.getStock_piece());
			pstmt.setInt(8, bean.getStock_total());
			pstmt.setString(9, bean.getStock_note());
			pstmt.setInt(10, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 재고 자료 삭제
	public void deleteStock(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from stock where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 참석자 개인별 평균점수 계산
	public void updateTotal(int numb1, int total) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "update stock set stock_total=? where numb=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, total);
			pstmt.setInt(2, numb1);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	
	// 재고 점검 ===============================================================================
	// 재고 점검 신규 추가
	public boolean StockC_Insert(Bean_Stock_c bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert stock_c(s_usid,s_date,s_check) values (?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getS_usid());
			pstmt.setString(2, bean.getS_date());
			pstmt.setString(3, bean.getS_check());

			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 재고 점검 내역 아이디 조건으로 조회
	public Vector<Bean_Stock_c> getStockCList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock_c> vlist = new Vector<Bean_Stock_c>();
		try {
			con = pool.getConnection();
			sql = "select * from stock_c order by s_date DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock_c bean = new Bean_Stock_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setS_usid(rs.getString("s_usid"));
				bean.setS_date(rs.getString("s_date"));
				bean.setS_check(rs.getString("s_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 재고 점검 내역 자료 전체 가져오기
	public int getStockCCount(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(numb) from stock_c  ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 재고 점검 내역 자료 수정을 위해 자료 가져오기
	public Bean_Stock_c getStockC(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Stock_c bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from stock_c where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Stock_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setS_usid(rs.getString("s_usid"));
				bean.setS_date(rs.getString("s_date"));
				bean.setS_check(rs.getString("s_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 재고 점검 내역 자료 코드 가져오기(뭐지? code, usid 세트였는데 후자는 지움)
	public Bean_Stock_c getStockC1(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Stock_c bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from stock_c where s_usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Stock_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setS_usid(rs.getString("s_usid"));
				bean.setS_date(rs.getString("s_date"));
				bean.setS_check(rs.getString("s_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 재고 점검 내역 수정
	public boolean updateStockC(Bean_Stock_c bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update stock_c set s_usid=?, s_date=?, s_check=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getS_usid());
			pstmt.setString(2, bean.getS_date());
			pstmt.setString(3, bean.getS_check());
			pstmt.setInt(4, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 재고 점검 내역 삭제
	public void deleteStockC(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from stock_c where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}	
	
	// 재고 점검 여부 클릭으로 변경
	public boolean updateStockPerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미완료")) {
				String sql = "update stock_c set s_check='완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				String sql = "update stock_c set s_check='미완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
	
	// 재고 목록 ===============================================================================
	// 재고 내역 신규 추가
	public boolean StockList_Insert(Bean_Stock_l bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert stock_l(stock_usid, stock_date, stock_code, stock_name, stock_exp,"
				+ "stock_pack, stock_piece, stock_total, stock_note, stock_check) "
				+ "values (?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getStock_usid());
			pstmt.setString(2, bean.getStock_date());
			pstmt.setString(3, bean.getStock_code());
			pstmt.setString(4, bean.getStock_name());
			pstmt.setString(5, bean.getStock_exp());
			pstmt.setInt(6, bean.getStock_pack());
			pstmt.setInt(7, bean.getStock_piece());
			pstmt.setInt(8, bean.getStock_total());
			pstmt.setString(9, bean.getStock_note());
			pstmt.setString(10, bean.getStock_check());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
	
	// 재고 내역  조회
	public Vector<Bean_Stock_l> getStockLList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock_l> vlist = new Vector<Bean_Stock_l>();
		try {
			con = pool.getConnection();
			sql = "select * from stock_l ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock_l bean = new Bean_Stock_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				bean.setStock_check(rs.getString("stock_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 재고 내역  조회
	public Vector<Bean_Stock_l> getStockLList1(String date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock_l> vlist = new Vector<Bean_Stock_l>();
		try {
			con = pool.getConnection();
			sql = "select * from stock_l where stock_date=? order by stock_code ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock_l bean = new Bean_Stock_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				bean.setStock_check(rs.getString("stock_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 재고 자료  조회
	public Vector<Bean_Stock_l> getStockLList2() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock_l> vlist = new Vector<Bean_Stock_l>();
		try {
			con = pool.getConnection();
			sql = "select * from stock_l";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock_l bean = new Bean_Stock_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				bean.setStock_check(rs.getString("stock_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 재고 내역  조회(내원 일정 관리용 재고 조회)
	public Vector<Bean_Stock_l> getStockLList3(String date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Stock_l> vlist = new Vector<Bean_Stock_l>();
		try {
			con = pool.getConnection();
			sql = "select stock_date, stock_code, stock_name, sum(stock_total) as stock_total from stock_l  where stock_date=? group by stock_code ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Stock_l bean = new Bean_Stock_l();
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_total(rs.getInt("stock_total"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	// 재고 자료 수(수정??? 카운트가 제일 어렵다)
	public int getStockLCount(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(numb) from stock_l ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 재고 내역 자료 수정을 위해 자료 가져오기
	public Bean_Stock_l getStockL(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Stock_l bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from stock_l where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Stock_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				bean.setStock_check(rs.getString("stock_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 재고 내역 자료 가져오기
	public Bean_Stock_l getStockL2(String date, int code) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Stock_l bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from stock_l where stock_date=? and stock_code=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setInt(2, code);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Stock_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				bean.setStock_check(rs.getString("stock_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 재고 내역 자료 코드 가져오기(뭐지? code, usid 세트였는데 후자는 지움)
	public Bean_Stock_l getStockL_code(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Stock_l bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from stock_l where stock_usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Stock_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setStock_usid(rs.getString("stock_usid"));
				bean.setStock_date(rs.getString("stock_date"));
				bean.setStock_code(rs.getString("stock_code"));
				bean.setStock_name(rs.getString("stock_name"));
				bean.setStock_exp(rs.getString("stock_exp"));
				bean.setStock_pack(rs.getInt("stock_pack"));
				bean.setStock_piece(rs.getInt("stock_piece"));
				bean.setStock_total(rs.getInt("stock_total"));
				bean.setStock_note(rs.getString("stock_note"));
				bean.setStock_check(rs.getString("stock_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 재고 내역 수정
	public boolean updateStockL(Bean_Stock_l bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update stock_l set stock_usid=?, stock_date=?, stock_code=?, stock_name=?, stock_exp=?,"
				+ "stock_pack=?, stock_piece=?, stock_total=?, stock_note=?, stock_check=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getStock_usid());
			pstmt.setString(2, bean.getStock_date());
			pstmt.setString(3, bean.getStock_code());
			pstmt.setString(4, bean.getStock_name());
			pstmt.setString(5, bean.getStock_exp());
			pstmt.setInt(6, bean.getStock_pack());
			pstmt.setInt(7, bean.getStock_piece());
			pstmt.setInt(8, bean.getStock_total());
			pstmt.setString(9, bean.getStock_note());
			pstmt.setString(10, bean.getStock_check());
			pstmt.setInt(11, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 재고 내역 삭제
	public void deleteStockL(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from stock_l where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	// 재고 목록 생성 전 존재여부 확인 (유통기한 추가한거 어디서 썼냐ㅡㅡ 찾아내)
	public boolean StockList_Check(String date, String code, String name, String exp) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select stock_date from stock_l where stock_date=? and stock_code=? and stock_name=? and stock_exp=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, code);
			pstmt.setString(3, name);
			pstmt.setString(4, exp);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 재고 목록 생성 전 존재여부 확인  
	public boolean StockList_Check2(String date, String code, String name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select stock_date from stock_l where stock_date=? and stock_code=? and stock_name=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, code);
			pstmt.setString(3, name);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}	
	
	// 재고 명단 생성 
	public boolean StockList_Create(String usid, String date, String code, String name, String exp, int pack, int piece, int total, String note) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert stock_l(stock_usid,stock_date,stock_code,stock_name,stock_exp,stock_pack,stock_piece,stock_total,stock_note,stock_check) "
				+ "values (?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			pstmt.setString(2, date);
			pstmt.setString(3, code);
			pstmt.setString(4, name);
			pstmt.setString(5, exp);
			pstmt.setInt(6, pack);
			pstmt.setInt(7, piece);
			pstmt.setInt(8, total);
			pstmt.setString(9, note);
			pstmt.setString(10, "미완료");

			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 목록 전체 삭제
	public void truncateList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "truncate table stock_l";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 리스트 생성 전 해당 날짜 리스트 전체 삭제(재고 리스트)
	public void truncate_stockList(String date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from stock_l where stock_date=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 재고 목록에서 점검 여부 클릭으로 변경
	public boolean updateStockListPerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미완료")) {
				String sql = "update stock_l set stock_check='완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				String sql = "update stock_l set stock_check='미완료' where numb=?";
				pstmt = con.prepareStatement(sql);					
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 재고 목록에서 점검 여부 클릭으로 변경(전체)
	public boolean updateStockListPermAll(String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미완료")) {
				String sql = "update stock_l set stock_check='완료' ";
				pstmt = con.prepareStatement(sql);
			} else {
				String sql = "update stock_l set stock_check='미완료' ";
				pstmt = con.prepareStatement(sql);					
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 참석자 개인별 평균점수 계산
	public void updateListTotal(int numb1, int total) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "update stock_l set stock_total=? where numb=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, total);
			pstmt.setInt(2, numb1);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	
	// 사용량 정보 ===============================================================================
	// 사용량 자료 수 세기
	public int getUsageCount(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(numb) from usage_a ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 사용량 자료  조회
	public Vector<Bean_Usage_a> getUsageList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Usage_a> vlist = new Vector<Bean_Usage_a>();
		try {
			con = pool.getConnection();
			sql = "select * from usage_a";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Usage_a bean = new Bean_Usage_a();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsage_usid(rs.getString("usage_usid"));
				bean.setUsage_date(rs.getString("usage_date"));
				bean.setUsage_code(rs.getString("usage_code"));
				bean.setUsage_name(rs.getString("usage_name"));
				bean.setUsage_total(rs.getInt("usage_total"));
				bean.setUsage_note(rs.getString("usage_note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	// 사용량 자료 가져오기(numb)
	public Bean_Usage_a getUsage(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Usage_a bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from usage_a where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Usage_a();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsage_usid(rs.getString("usage_usid"));
				bean.setUsage_date(rs.getString("usage_date"));
				bean.setUsage_code(rs.getString("usage_code"));
				bean.setUsage_name(rs.getString("usage_name"));
				bean.setUsage_total(rs.getInt("usage_total"));
				bean.setUsage_note(rs.getString("usage_note"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 사용량 자료 삭제
	public void deleteUsage(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from usage_a where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}	

	// 사용량 자료 수정
	public boolean updateUsage(Bean_Usage_a bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update usage_a set usage_usid=?, usage_date=?, usage_code=?, usage_name=?,"
				+ "usage_total=?, usage_note=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsage_usid());
			pstmt.setString(2, bean.getUsage_date());
			pstmt.setString(3, bean.getUsage_code());
			pstmt.setString(4, bean.getUsage_name());
			pstmt.setInt(5, bean.getUsage_total());
			pstmt.setString(6, bean.getUsage_note());
			pstmt.setInt(7, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 처방 자료 신규 추가
	public boolean Usage_Insert(Bean_Usage_a bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert usage_a(usage_usid, usage_date, usage_code, usage_name, usage_total, usage_note)"
				+ "values (?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsage_usid());
			pstmt.setString(2, bean.getUsage_date());
			pstmt.setString(3, bean.getUsage_code());
			pstmt.setString(4, bean.getUsage_name());
			pstmt.setInt(5, bean.getUsage_total());
			pstmt.setString(6, bean.getUsage_note());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	
	// 처방 자료 가져오기(usid)
	public Bean_Usage_a getUsage1(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Usage_a bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from usage_a where usage_usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Usage_a();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsage_usid(rs.getString("usage_usid"));
				bean.setUsage_date(rs.getString("usage_date"));
				bean.setUsage_code(rs.getString("usage_code"));
				bean.setUsage_name(rs.getString("usage_name"));
				bean.setUsage_total(rs.getInt("usage_total"));
				bean.setUsage_note(rs.getString("usage_note"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	
	
	
	// 날짜별 처방 확인 ===============================================================================	
	// 처방 확인 여부 클릭으로 변경
	public boolean updateUsageCheckPerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미완료")) {
				String sql = "update usage_c set u_check='완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				String sql = "update usage_c set u_check='미완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 날짜별 처방 내역 자료 전체 가져오기
	public int getUsageCheckCount(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(numb) from usage_c  ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 처방 내역 아이디 조건으로 조회
	public Vector<Bean_Usage_c> getUsageCheckList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Usage_c> vlist = new Vector<Bean_Usage_c>();
		try {
			con = pool.getConnection();
			sql = "select * from usage_c order by u_date DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Usage_c bean = new Bean_Usage_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setU_usid(rs.getString("u_usid"));
				bean.setU_date(rs.getString("u_date"));
				bean.setU_check(rs.getString("u_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 처방 확인 내역 자료 가져오기(numb)
	public Bean_Usage_c getUsageCheck(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Usage_c bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from usage_c where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Usage_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setU_usid(rs.getString("u_usid"));
				bean.setU_date(rs.getString("u_date"));
				bean.setU_check(rs.getString("u_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 처방 확인 내역 삭제
	public void deleteUsageCheck(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from usage_c where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 처방 확인 신규 추가
	public boolean UsageCheck_Insert(Bean_Usage_c bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert usage_c(u_usid,u_date,u_check) values (?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getU_usid());
			pstmt.setString(2, bean.getU_date());
			pstmt.setString(3, bean.getU_check());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 처방 확인 내역 자료 가져오기(usid)
	public Bean_Usage_c getUsageCheck1(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Usage_c bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from usage_c where u_usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Usage_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setU_usid(rs.getString("u_usid"));
				bean.setU_date(rs.getString("u_date"));
				bean.setU_check(rs.getString("u_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 처방 확인 내역 수정
	public boolean updateUsageCheck(Bean_Usage_c bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update usage_c set u_usid=?, u_date=?, u_check=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getU_usid());
			pstmt.setString(2, bean.getU_date());
			pstmt.setString(3, bean.getU_check());
			pstmt.setInt(4, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	
	// 처방 리스트 ===============================================================================
	// 처방 내역 조회
	public Vector<Bean_Usage_a> getUsageList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Usage_a> vlist = new Vector<Bean_Usage_a>();
		try {
			con = pool.getConnection();
			sql = "select * from usage_a";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Usage_a bean = new Bean_Usage_a();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsage_usid(rs.getString("usage_usid"));
				bean.setUsage_date(rs.getString("usage_date"));
				bean.setUsage_code(rs.getString("usage_code"));
				bean.setUsage_name(rs.getString("usage_name"));
				bean.setUsage_total(rs.getInt("usage_total"));
				bean.setUsage_note(rs.getString("usage_note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 리스트 생성 전 존재여부 확인 
	public boolean UsageList_Check(String date, String code) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select usage_date from usage_l where usage_date=? and usage_code=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, code);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 리스트 생성 
	public boolean UsageList_Create(String usid, String date, String code, String name, int total, String note) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert usage_l(usage_usid,usage_date,usage_code,usage_name,usage_total,usage_note,usage_check) "
				+ "values (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			pstmt.setString(2, date);
			pstmt.setString(3, code);
			pstmt.setString(4, name);
			pstmt.setInt(5, total);
			pstmt.setString(6, note);
			pstmt.setString(7, "미완료");

			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
	
	// 리스트  조회
	public Vector<Bean_Usage_l> getUsageLList(String date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Usage_l> vlist = new Vector<Bean_Usage_l>();
		try {
			con = pool.getConnection();
			sql = "select * from usage_l where usage_date=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Usage_l bean = new Bean_Usage_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsage_usid(rs.getString("usage_usid"));
				bean.setUsage_date(rs.getString("usage_date"));
				bean.setUsage_code(rs.getString("usage_code"));
				bean.setUsage_name(rs.getString("usage_name"));
				bean.setUsage_total(rs.getInt("usage_total"));
				bean.setUsage_note(rs.getString("usage_note"));
				bean.setUsage_check(rs.getString("usage_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	// 리스트에서 확인 여부 클릭으로 변경
	public boolean updateUsageListPerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미완료")) {
				String sql = "update usage_l set usage_check='완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				String sql = "update usage_l set usage_check='미완료' where numb=?";
				pstmt = con.prepareStatement(sql);					
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 리스트 조회
	public Bean_Usage_l getUsageLList(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Usage_l bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from usage_l where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Usage_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsage_usid(rs.getString("usage_usid"));
				bean.setUsage_date(rs.getString("usage_date"));
				bean.setUsage_code(rs.getString("usage_code"));
				bean.setUsage_name(rs.getString("usage_name"));
				bean.setUsage_total(rs.getInt("usage_total"));
				bean.setUsage_note(rs.getString("usage_note"));
				bean.setUsage_check(rs.getString("usage_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 리스트 삭제
	public void deleteUsageList(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from usage_l where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}	

	// 리스트 수정
	public boolean updateUsageList(Bean_Usage_l bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update usage_l set usage_date=?, usage_code=?, usage_name=?,"
				+ "usage_total=?, usage_note=?, usage_check=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsage_date());
			pstmt.setString(2, bean.getUsage_code());
			pstmt.setString(3, bean.getUsage_name());
			pstmt.setInt(4, bean.getUsage_total());
			pstmt.setString(5, bean.getUsage_note());
			pstmt.setString(6, bean.getUsage_check());
			pstmt.setInt(7, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	
	// 정산 정보 ===============================================================================
	// 정산 확인 여부 클릭으로 변경
	public boolean updateMngCheckPerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미완료")) {
				String sql = "update mng_c set m_check='완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				String sql = "update mng_c set m_check='미완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 날짜별 정산 내역 자료 수
	public int getMngCheckCount(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(numb) from mng_c  ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}	

	// 정산 내역 아이디 조건으로 조회
	public Vector<Bean_Mng_c> getMngCheckList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Mng_c> vlist = new Vector<Bean_Mng_c>();
		try {
			con = pool.getConnection();
			sql = "select * from mng_c order by m_y_date DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Mng_c bean = new Bean_Mng_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setM_usid(rs.getString("m_usid"));
				bean.setM_y_date(rs.getString("m_y_date"));
				bean.setM_t_date(rs.getString("m_t_date"));
				bean.setM_check(rs.getString("m_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	

	// 정산 확인 신규 추가
	public boolean mngCheck_Insert(Bean_Mng_c bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert mng_c(m_usid,m_y_date,m_t_date,m_check) values (?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getM_usid());
			pstmt.setString(2, bean.getM_y_date());
			pstmt.setString(3, bean.getM_t_date());
			pstmt.setString(4, bean.getM_check());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 정산 확인 내역 자료 가져오기(usid)
	public Bean_Mng_c getMngCheck1(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Mng_c bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from mng_c where m_usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Mng_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setM_usid(rs.getString("m_usid"));
				bean.setM_y_date(rs.getString("m_y_date"));
				bean.setM_t_date(rs.getString("m_t_date"));
				bean.setM_check(rs.getString("m_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 정산 확인 내역 자료 가져오기(numb)
	public Bean_Mng_c getMngCheck(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Mng_c bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from mng_c where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Mng_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setM_usid(rs.getString("m_usid"));
				bean.setM_y_date(rs.getString("m_y_date"));
				bean.setM_t_date(rs.getString("m_t_date"));
				bean.setM_check(rs.getString("m_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 정산 확인 내역 삭제
	public void deleteMngCheck(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from mng_c where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}	

	// 정산 확인 내역 수정
	public boolean updateMngCheck(Bean_Mng_c bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update mng_c set m_usid=?, m_y_date=?, m_t_date=?, m_check=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getM_usid());
			pstmt.setString(2, bean.getM_y_date());
			pstmt.setString(3, bean.getM_t_date());
			pstmt.setString(4, bean.getM_check());
			pstmt.setInt(5, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 리스트 생성 전 해당 날짜 리스트 전체 삭제(정산 리스트)
	public void truncate_mngList(String date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from mng_l where mng_date=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 일별 정산 목록 생성 전 존재여부 확인 
	public boolean mngList_Check(String date, String code, String name, String exp) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select mng_date from mng_l where mng_date=? and mng_code=? and mng_name=? and mng_exp=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, code);
			pstmt.setString(3, name);
			pstmt.setString(4, exp);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 일별 정산 목록 생성 
	public boolean mngList_Create(String usid, String date, String code, String name, String exp, int pack, int piece, int total, String note) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert mng_l(mng_usid,mng_date,mng_code,mng_name,mng_exp,mng_pack,mng_piece,mng_total,mng_note,mng_check) "
				+ "values (?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			pstmt.setString(2, date);
			pstmt.setString(3, code);
			pstmt.setString(4, name);
			pstmt.setString(5, exp);
			pstmt.setInt(6, pack);
			pstmt.setInt(7, piece);
			pstmt.setInt(8, total);
			pstmt.setString(9, note);
			pstmt.setString(10, "미완료");

			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 정산 내역  조회
	public Vector<Bean_Mng_l> getMngList(String date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Mng_l> vlist = new Vector<Bean_Mng_l>();
		try {
			con = pool.getConnection();
			sql = "select * from mng_l where mng_date=? order by mng_code ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Mng_l bean = new Bean_Mng_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setMng_usid(rs.getString("mng_usid"));
				bean.setMng_date(rs.getString("mng_date"));
				bean.setMng_code(rs.getString("mng_code"));
				bean.setMng_name(rs.getString("mng_name"));
				bean.setMng_exp(rs.getString("mng_exp"));
				bean.setMng_pack(rs.getInt("mng_pack"));
				bean.setMng_piece(rs.getInt("mng_piece"));
				bean.setMng_total(rs.getInt("mng_total"));
				bean.setMng_note(rs.getString("mng_note"));
				bean.setMng_check(rs.getString("mng_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 정산 내역  조회
	public Vector<Bean_Mng_l> getMngList1(String date, String code) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Mng_l> vlist = new Vector<Bean_Mng_l>();
		try {
			con = pool.getConnection();
			sql = "select * from mng_l where mng_date=? and mng_code=? order by mng_code ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Mng_l bean = new Bean_Mng_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setMng_usid(rs.getString("mng_usid"));
				bean.setMng_date(rs.getString("mng_date"));
				bean.setMng_code(rs.getString("mng_code"));
				bean.setMng_name(rs.getString("mng_name"));
				bean.setMng_exp(rs.getString("mng_exp"));
				bean.setMng_pack(rs.getInt("mng_pack"));
				bean.setMng_piece(rs.getInt("mng_piece"));
				bean.setMng_total(rs.getInt("mng_total"));
				bean.setMng_note(rs.getString("mng_note"));
				bean.setMng_check(rs.getString("mng_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	// 일별 정산 목록에서 점검 여부 클릭으로 변경
	public boolean updateMngListPerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미완료")) {
				String sql = "update mng_l set mng_check='완료' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				String sql = "update mng_l set mng_check='미완료' where numb=?";
				pstmt = con.prepareStatement(sql);					
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 총량 계산 후 업데이트(mngList_c_backup용, 일단 계산업데이트 되는거)
	public void updateMngListTotal(String exp, String code, int pack, int piece, int total) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "update mng_l set mng_pack=?, mng_piece=?, mng_total=? where mng_code=? and mng_exp=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pack);
			pstmt.setInt(2, piece);
			pstmt.setInt(3, total);
			pstmt.setString(4, code);
			pstmt.setString(5, exp);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}	
	
	// 총량 계산 후 업데이트
	public void updateMngListTotal2(String date, String exp, String code, int pack, int piece, int total) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "update mng_l set mng_pack=?, mng_piece=?, mng_total=? where mng_code=? and mng_exp=? and mng_date=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pack);
			pstmt.setInt(2, piece);
			pstmt.setInt(3, total);
			pstmt.setString(4, code);
			pstmt.setString(5, exp);
			pstmt.setString(6, date);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 중복 코드 삭제 delete문으로
	public void truncateTotal() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from mng_l where 조건어떻게???";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	// 정산 내역 자료 수정을 위해 자료 가져오기
	public Bean_Mng_l getMngL(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Mng_l bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from mng_l where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Mng_l();
				bean.setNumb(rs.getInt("numb"));
				bean.setMng_usid(rs.getString("mng_usid"));
				bean.setMng_date(rs.getString("mng_date"));
				bean.setMng_code(rs.getString("mng_code"));
				bean.setMng_name(rs.getString("mng_name"));
				bean.setMng_exp(rs.getString("mng_exp"));
				bean.setMng_pack(rs.getInt("mng_pack"));
				bean.setMng_piece(rs.getInt("mng_piece"));
				bean.setMng_total(rs.getInt("mng_total"));
				bean.setMng_note(rs.getString("mng_note"));
				bean.setMng_check(rs.getString("mng_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 정산 내역 삭제
	public void deleteMngL(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from mng_l where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}	

	// 재고 내역 수정
	public boolean updateMngL(Bean_Mng_l bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update mng_l set mng_usid=?, mng_date=?, mng_code=?, mng_name=?, mng_exp=?,"
				+ "mng_pack=?, mng_piece=?, mng_total=?, mng_note=?, mng_check=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMng_usid());
			pstmt.setString(2, bean.getMng_date());
			pstmt.setString(3, bean.getMng_code());
			pstmt.setString(4, bean.getMng_name());
			pstmt.setString(5, bean.getMng_exp());
			pstmt.setInt(6, bean.getMng_pack());
			pstmt.setInt(7, bean.getMng_piece());
			pstmt.setInt(8, bean.getMng_total());
			pstmt.setString(9, bean.getMng_note());
			pstmt.setString(10, bean.getMng_check());
			pstmt.setInt(11, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	
	// 내원 일정 관리 ===============================================================================
	// 내원 일정 관리 수
	public int getScheduleCount(String check, String keyWord, String keyField, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (check.equals("S") | check.equals("A")) {
				sql = "select count(numb) from schedule ";
			    pstmt = con.prepareStatement(sql);
			} else if (check.equals("B")) {
				sql = "select count(numb) from schedule where "  + keyField + " like ? ";
			    pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 내원 일정 관리 아이디 조건으로 조회
	public Vector<Bean_Schedule> getScheduleList(String check, String keyWord, String keyField, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Schedule> vlist = new Vector<Bean_Schedule>();
		try {
			con = pool.getConnection();
			if (check.equals("S") | check.equals("A")) {
				sql = "select * from schedule order by rx_next ";
			    pstmt = con.prepareStatement(sql);
			} else if (check.equals("B")) {
				sql = "select * from schedule where "  + keyField + " like ? order by rx_next ";
			    pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Schedule bean = new Bean_Schedule();
				bean.setNumb(rs.getInt("numb"));
				bean.setChart_numb(rs.getString("chart_numb"));
				bean.setChart_name(rs.getString("chart_name"));
				bean.setRx_code(rs.getString("rx_code"));
				bean.setRx_name(rs.getString("rx_name"));
				bean.setRx_amnt(rs.getInt("rx_amnt"));
				bean.setRx_date(rs.getInt("rx_date"));
				bean.setRx_next(rs.getString("rx_next"));
				bean.setNote(rs.getString("note"));
				bean.setSt_amnt(rs.getInt("st_amnt"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 정산 내역  조회
	public Vector<Bean_Schedule> getScheduleList2(String code, String name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Schedule> vlist = new Vector<Bean_Schedule>();
		try {
			con = pool.getConnection();
			sql = "select * from schedule where rx_code=? and rx_name=? order by rx_code ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.setString(2, name);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Schedule bean = new Bean_Schedule();
				bean.setNumb(rs.getInt("numb"));
				bean.setChart_numb(rs.getString("chart_numb"));
				bean.setChart_name(rs.getString("chart_name"));
				bean.setRx_code(rs.getString("rx_code"));
				bean.setRx_name(rs.getString("rx_name"));
				bean.setRx_amnt(rs.getInt("rx_amnt"));
				bean.setRx_date(rs.getInt("rx_date"));
				bean.setRx_next(rs.getString("rx_next"));
				bean.setNote(rs.getString("note"));
				bean.setSt_amnt(rs.getInt("st_amnt"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	

	// 정산 내역  조회
	public Vector<Bean_Schedule> getScheduleList3(String date, String code) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Schedule> vlist = new Vector<Bean_Schedule>();
		try {
			con = pool.getConnection();
			sql = "select * from mng_l where mng_date=? and mng_code=? order by mng_code ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Schedule bean = new Bean_Schedule();
				bean.setNumb(rs.getInt("numb"));
				bean.setChart_numb(rs.getString("chart_numb"));
				bean.setChart_name(rs.getString("chart_name"));
				bean.setRx_code(rs.getString("rx_code"));
				bean.setRx_name(rs.getString("rx_name"));
				bean.setRx_amnt(rs.getInt("rx_amnt"));
				bean.setRx_date(rs.getInt("rx_date"));
				bean.setRx_next(rs.getString("rx_next"));
				bean.setNote(rs.getString("note"));
				bean.setSt_amnt(rs.getInt("st_amnt"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	// 내원 일정 신규 추가
	public boolean Schedule_Insert(Bean_Schedule bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert schedule(chart_numb,chart_name,rx_code,rx_name,rx_amnt,rx_date,rx_next,note,st_amnt) values (?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getChart_numb());
			pstmt.setString(2, bean.getChart_name());
			pstmt.setString(3, bean.getRx_code());
			pstmt.setString(4, bean.getRx_name());
			pstmt.setInt(5, bean.getRx_amnt());
			pstmt.setInt(6, bean.getRx_date());
			pstmt.setString(7, bean.getRx_next());
			pstmt.setString(8, bean.getNote());
			pstmt.setInt(9, bean.getSt_amnt());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 일정 내역 조회 (numb)
	public Bean_Schedule getSchedule(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Schedule bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from schedule where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Schedule();
				bean.setNumb(rs.getInt("numb"));
				bean.setChart_numb(rs.getString("chart_numb"));
				bean.setChart_name(rs.getString("chart_name"));
				bean.setRx_code(rs.getString("rx_code"));
				bean.setRx_name(rs.getString("rx_name"));
				bean.setRx_amnt(rs.getInt("rx_amnt"));
				bean.setRx_date(rs.getInt("rx_date"));
				bean.setRx_next(rs.getString("rx_next"));
				bean.setNote(rs.getString("note"));
				bean.setSt_amnt(rs.getInt("st_amnt"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 일정 내역 조회 (numb)
	public Bean_Schedule getSchedule2() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Schedule bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from schedule ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Schedule();
				bean.setNumb(rs.getInt("numb"));
				bean.setChart_numb(rs.getString("chart_numb"));
				bean.setChart_name(rs.getString("chart_name"));
				bean.setRx_code(rs.getString("rx_code"));
				bean.setRx_name(rs.getString("rx_name"));
				bean.setRx_amnt(rs.getInt("rx_amnt"));
				bean.setRx_date(rs.getInt("rx_date"));
				bean.setRx_next(rs.getString("rx_next"));
				bean.setNote(rs.getString("note"));
				bean.setSt_amnt(rs.getInt("st_amnt"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 일정 내역 조회 (numb) ??????????
	public Bean_Schedule getSchedule3(String code, String name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Schedule bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from schedule where rx_code=? and rx_name=? ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			pstmt.setString(1, code);
			pstmt.setString(2, name);
			if (rs.next()) {
				bean = new Bean_Schedule();
				bean.setNumb(rs.getInt("numb"));
				bean.setChart_numb(rs.getString("chart_numb"));
				bean.setChart_name(rs.getString("chart_name"));
				bean.setRx_code(rs.getString("rx_code"));
				bean.setRx_name(rs.getString("rx_name"));
				bean.setRx_amnt(rs.getInt("rx_amnt"));
				bean.setRx_date(rs.getInt("rx_date"));
				bean.setRx_next(rs.getString("rx_next"));
				bean.setNote(rs.getString("note"));
				bean.setSt_amnt(rs.getInt("st_amnt"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 내원 일정 수정
	public boolean updateSchedule(Bean_Schedule bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update schedule set chart_numb=?, chart_name=?, rx_code=?, rx_name=?, rx_amnt=?,"
				+ "rx_date=?, rx_next=?, note=?, st_amnt=? where numb=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getChart_numb());
			pstmt.setString(2, bean.getChart_name());
			pstmt.setString(3, bean.getRx_code());
			pstmt.setString(4, bean.getRx_name());
			pstmt.setInt(5, bean.getRx_amnt());
			pstmt.setInt(6, bean.getRx_date());
			pstmt.setString(7, bean.getRx_next());
			pstmt.setString(8, bean.getNote());
			pstmt.setInt(9, bean.getSt_amnt());
			pstmt.setInt(10, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 내원 일정 수정(다음 내원일 업데이트)
	public boolean updateScheduleDate(int numb, String rx_next1) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update schedule set rx_next=? where numb=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rx_next1);
			pstmt.setInt(2, numb);
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 내원 일정 수정(당일 재고 업데이트)
	public boolean updateScheduleStock(String rx_code, String rx_name, int st_amnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update schedule set st_amnt=? where rx_code=? and rx_name=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, st_amnt);
			pstmt.setString(2, rx_code);
			pstmt.setString(3, rx_name);
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
	
	// 내원 일정 삭제
	public void deleteSchedule(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from schedule where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}	

	
	// 발주 확인 ===============================================================================	
	// 발주 확인 배송 여부 클릭으로 변경
	public boolean updateOrderCheckPerm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (perm.equals("미배송")) {
				String sql = "update order_c set o_check='배송완료' where numb=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				String sql = "update order_c set o_check='미배송' where numb=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 날짜별 발주 확인 자료 수
	public int getOrderCheckCount(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(numb) from order_c  ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}	

	// 발주 확인 아이디 조건으로 조회
	public Vector<Bean_Order_c> getOrderCheckList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Order_c> vlist = new Vector<Bean_Order_c>();
		try {
			con = pool.getConnection();
			sql = "select * from order_c order by o_y_date DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Order_c bean = new Bean_Order_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setO_usid(rs.getString("o_usid"));
				bean.setO_y_date(rs.getString("o_y_date"));
				bean.setO_t_date(rs.getString("o_t_date"));
				bean.setO_check(rs.getString("o_check"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 발주 확인 신규 추가
	public boolean orderCheck_Insert(Bean_Order_c bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert order_c(o_usid,o_y_date,o_t_date,o_check) values (?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getO_usid());
			pstmt.setString(2, bean.getO_y_date());
			pstmt.setString(3, bean.getO_t_date());
			pstmt.setString(4, bean.getO_check());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 발주 확인 내역 자료 가져오기(usid)
	public Bean_Order_c getOrderCheck(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Order_c bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from order_c where o_usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Order_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setO_usid(rs.getString("o_usid"));
				bean.setO_y_date(rs.getString("o_y_date"));
				bean.setO_t_date(rs.getString("o_t_date"));
				bean.setO_check(rs.getString("o_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 정산 확인 내역 자료 가져오기(numb)
	public Bean_Order_c getOrderCheck1(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Order_c bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from order_c where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Order_c();
				bean.setNumb(rs.getInt("numb"));
				bean.setO_usid(rs.getString("o_usid"));
				bean.setO_y_date(rs.getString("o_y_date"));
				bean.setO_t_date(rs.getString("o_t_date"));
				bean.setO_check(rs.getString("o_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	
	
	// 발주 확인 내역 수정
	public boolean updateOrderCheck(Bean_Order_c bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update order_c set o_usid=?, o_y_date=?, o_t_date=?, o_check=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getO_usid());
			pstmt.setString(2, bean.getO_y_date());
			pstmt.setString(3, bean.getO_t_date());
			pstmt.setString(4, bean.getO_check());
			pstmt.setInt(5, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	

	// 발주 확인 내역 삭제
	public void deleteOrderCheck(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from order_c where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	// 코드 내역 아이디 조건으로 조회
	public Vector<Bean_Code> getOrderKeyWord(String keyField) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Code> vlist = new Vector<Bean_Code>();
		try {
			con = pool.getConnection();
			if (keyField.equals("all_insulin")) {
				sql = "select * from code where substr(code,1,1)='B' ";
			    pstmt = con.prepareStatement(sql);
			} else if (keyField.equals("B2")) {
				sql = "select * from code where substr(code,2,1)='2' ";
			    pstmt = con.prepareStatement(sql);
			} else if (keyField.equals("B3")) {
				sql = "select * from code where substr(code,2,1)='3' ";
			    pstmt = con.prepareStatement(sql);
			} else if (keyField.equals("B5")) {
				sql = "select * from code where substr(code,2,1)='5' ";
			    pstmt = con.prepareStatement(sql);
			} else if (keyField.equals("A제약")) {
				sql = "select * from code where substr(code,2,1)='2' ";
			    pstmt = con.prepareStatement(sql);
			} else if (keyField.equals("B제약")) {
				sql = "select * from code where substr(code,2,1)!='2' ";
			    pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Code bean = new Bean_Code();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setAgnt(rs.getString("agnt"));
				bean.setCode(rs.getString("code"));
				bean.setName(rs.getString("name"));
				bean.setNote(rs.getString("note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	

	// 거래처 아이디 조건으로 조회
	public Vector<Bean_Order_a> getOrderAngtList(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Order_a> vlist = new Vector<Bean_Order_a>();
		try {
			con = pool.getConnection();
			sql = "select * from order_a ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Order_a bean = new Bean_Order_a();
				bean.setNumb(rs.getInt("numb"));
				bean.setAgnt(rs.getString("agnt"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setMail(rs.getString("mail"));
				bean.setPost(rs.getString("post"));
				bean.setAddr(rs.getString("addr"));
				bean.setNote(rs.getString("note"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	

	// 거래처 자료 가져오기
	public Bean_Order_a getOrderAgnt() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Order_a bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from order_a ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Order_a();
				bean.setNumb(rs.getInt("numb"));
				bean.setAgnt(rs.getString("agnt"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setMail(rs.getString("mail"));
				bean.setPost(rs.getString("post"));
				bean.setAddr(rs.getString("addr"));
				bean.setNote(rs.getString("note"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	

	// 거래처 자료 가져오기(numb)
	public Bean_Order_a getOrderAgnt1(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Order_a bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from order_a where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Order_a();
				bean.setNumb(rs.getInt("numb"));
				bean.setAgnt(rs.getString("agnt"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setMail(rs.getString("mail"));
				bean.setPost(rs.getString("post"));
				bean.setAddr(rs.getString("addr"));
				bean.setNote(rs.getString("note"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}	
	
	// 거래처 신규 추가
	public boolean orderAgnt_Insert(Bean_Order_a bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert order_a(agnt,name,telp,mail,post,addr,note) values (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getAgnt());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getTelp());
			pstmt.setString(4, bean.getMail());
			pstmt.setString(5, bean.getPost());
			pstmt.setString(6, bean.getAddr());
			pstmt.setString(7, bean.getNote());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}	
	
	// 거래처 정보 수정
	public boolean updateOrderAgnt(Bean_Order_a bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update order_a set agnt=?, name=?, telp=?, mail=?, post=?, addr=?, note=? where numb = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getAgnt());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getTelp());
			pstmt.setString(4, bean.getMail());
			pstmt.setString(5, bean.getPost());
			pstmt.setString(6, bean.getAddr());
			pstmt.setString(7, bean.getNote());
			pstmt.setInt(8, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 거래처 정보 삭제
	public void deleteOrderAgnt(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from order_a where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}	
	
}