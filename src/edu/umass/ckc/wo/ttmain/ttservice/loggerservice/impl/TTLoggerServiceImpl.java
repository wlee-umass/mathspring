package edu.umass.ckc.wo.ttmain.ttservice.loggerservice.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.Year;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import edu.umass.ckc.wo.beans.ClassInfo;
import edu.umass.ckc.wo.beans.Classes;
import edu.umass.ckc.wo.cache.ProblemMgr;
import edu.umass.ckc.wo.db.DbClass;
import edu.umass.ckc.wo.db.DbPedagogy;
import edu.umass.ckc.wo.db.DbTeacher;
import edu.umass.ckc.wo.smgr.User;
import edu.umass.ckc.wo.ttmain.ttconfiguration.TTConfiguration;
import edu.umass.ckc.wo.ttmain.ttconfiguration.errorCodes.ErrorCodeMessageConstants;
import edu.umass.ckc.wo.ttmain.ttconfiguration.errorCodes.TTCustomException;
import edu.umass.ckc.wo.ttmain.ttmodel.CreateClassForm;
import edu.umass.ckc.wo.ttmain.ttservice.loggerservice.TTLoggerService;
import edu.umass.ckc.wo.tutor.Settings;

/**
 * Created by Neeraj on 3/25/2017.
 */
@Service
public class TTLoggerServiceImpl implements TTLoggerService {
    private static Logger logger = Logger.getLogger(TTLoggerServiceImpl.class);
   
    @Autowired
    private TTConfiguration connection;

    @Override
    public void tloggerAssist(int teacherId, int sessionId, String action, String activityName) {
        
		System.out.println("tloggerAssist");
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
        	Connection conn = connection.getConnection();
            String q = "insert into teacherlog (teacherId,action,activityName,time) values (?,?,?,?)";

            ps = connection.getConnection().prepareStatement(q, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, teacherId);            
            
            ps.setString(2,action);
            if (activityName == null) {
                ps.setNull(3,Types.VARCHAR);
            }
            else ps.setString(3,activityName);
            ps.setTimestamp(4,new Timestamp(System.currentTimeMillis()));
        	System.out.println("executeUpdate");
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            rs.next();
            int newId = rs.getInt(1);
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        }
    }
}