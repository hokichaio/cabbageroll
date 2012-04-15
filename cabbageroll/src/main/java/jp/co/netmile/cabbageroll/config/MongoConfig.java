package jp.co.netmile.cabbageroll.config;

import jp.co.netmile.cabbageroll.service.EnqService;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.MongoDbFactory;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;

import com.mongodb.MongoURI;

/**
 * MongoDB Configuration.
 */
@Configuration
public class MongoConfig {

	@Value("${mongo.url}")
	private String mongoUrl;

	@Bean
	public MongoOperations mongoOperations() throws Exception {
		MongoURI mongoURI = new MongoURI(mongoUrl);
		MongoDbFactory mongoDbFactory = new SimpleMongoDbFactory(mongoURI);
		return new MongoTemplate(mongoDbFactory);
	}

}
