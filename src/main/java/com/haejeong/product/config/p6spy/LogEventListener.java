package com.haejeong.product.config.p6spy;

import java.sql.SQLException;

import com.p6spy.engine.common.ConnectionInformation;
import com.p6spy.engine.event.JdbcEventListener;
import com.p6spy.engine.spy.P6SpyOptions;

public class LogEventListener extends JdbcEventListener {

	@Override
	public void onAfterGetConnection(ConnectionInformation connectionInformation, SQLException e) {
		P6SpyOptions.getActiveInstance().setLogMessageFormat(P6spyFormatter.class.getName());
	}

}
