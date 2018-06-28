/**
 * Logbox Appender
 * File Name: logbox.cfc
 * @author saura.mandal
 * @date 6/27/18
 **/
<cfcomponent displayname = "" hint = "" access = "public" accessors = true extends = "logbox.system.logging.AbstractAppender">
		<cffunction name="init" access="public" returntype="FileAppender" hint="Constructor" output="false">
	    <cfargument name="name" type="string" required="true" hint="The unique name for this appender."/>
	    <cfargument name="properties" type="struct" required="false" default="#structnew()#" hint="A map of configuration properties for the appender"/>
	    <cfargument name="layout" type="string"  required="true"  default="" hint="The layout class to use in this appender for custom message rendering."/>
	    <cfargument name="levelMin" type="numeric" required="false" default="0" hint="The default log level for this appender, by default it is 0. Optional. ex: LogBox.logLevels.WARN"/>
	    <cfargument name="levelMax" type="numeric" required="false" default="4" hint="The default log level for this appender, by default it is 5. Optional. ex: LogBox.logLevels.WARN"/>

	    <cfscript>
	        super.init(argumentCollection=arguments);

	        // Setup Properties
	        if(NOT propertyExists("filepath")){
	            $throw(message="Filepath property not defined",type="FileAppender.PropertyNotFound");
	        }
	        if(NOT propertyExists("autoExpand")){
	            setProperty("autoExpand",true);
	        }
	        if(NOT propertyExists("filename")){
	            setProperty("filename",getName());
	        }
	        if( NOT propertyExists("fileEncoding") ){
	            setProperty("fileEncoding","UTF-8");
	        }

	        // Setup the log file full path
	        instance.logFullpath = getProperty("filePath");
	        // Clean ending slash
	        if( right(instance.logFullpath,1) eq "/" OR right(instance.logFullPath,1) eq "\"){
	            instance.logFullPath = left(instance.logFullpath, len(instance.logFullPath)-1);
	        }
	        instance.logFullPath = instance.logFullpath & "/" & getProperty("filename") & ".log";

	        // Do we expand the path?
	        if( getProperty("autoExpand") ){
	            instance.logFullPath = expandPath(instance.logFullpath);
	        }

	        //lock information
	        instance.lockName = getname() & "logOperation";
	        instance.lockTimeout = 25;
	        return this;
	    </cfscript>
	</cffunction>
</cfcomponent>