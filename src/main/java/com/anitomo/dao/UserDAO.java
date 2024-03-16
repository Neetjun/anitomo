package com.anitomo.dao;


import com.anitomo.dto.UserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO
{
    private SqlSession session;
    private String namespace = "com.anitomo.dao.userDAO.";

    public UserDAO(SqlSession session)
    {
        this.session = session;
    }

    public int registerUser(UserDTO userDTO)
    {
        return session.insert(namespace+"registerUser",userDTO);
    }
    public int countUser()
    {
        return session.selectOne(namespace+"countUser");
    }
    public int checkId(String userId) {return session.selectOne(namespace+"checkId",userId);}

    public UserDTO login(UserDTO userDTO)
    {
        UserDTO loginUser = session.selectOne(namespace+"login",userDTO);
        return loginUser;
    }
}
