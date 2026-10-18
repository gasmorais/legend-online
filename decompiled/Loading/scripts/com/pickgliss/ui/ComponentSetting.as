package com.pickgliss.ui
{
   import com.greensock.easing.Sine;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.vo.FileVo;
   import com.pickgliss.utils.StringUtils;
   import flash.display.DisplayObjectContainer;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public final class ComponentSetting
   {
      
      public static var roleNum:int = 0;
      
      public static var BUTTON_PRESS_START_TIME:int = 500;
      
      public static var BUTTON_PRESS_STEP_TIME:int = 100;
      
      public static var COMBOBOX_HIDE_TIME:Number = 0;
      
      public static var COMBOBOX_SHOW_TIME:Number = 0.5;
      
      public static var BITMAPDATA_TAG_NAME:String = "bitmapData";
      
      public static var BITMAP_TAG_NAME:String = "bitmap";
      
      public static var SIMPLE_ALERT_STYLE:String = "SimpleAlert";
      
      public static var FUNCTION_ALERT_STLE:String = "FunctionAlert";
      
      public static var USEBINDPOINT_ALERT_STYLE:String = "UseBindPointAlertStyle";
      
      public static var CHATINVIE_ALERT_STYLE:String = "ChatInvieAlertStyle";
      
      public static var SIMPLE_BITMAP_BUTTON_FILTER:String = "null,lightFilter,null,grayFilter";
      
      public static var ALERT_BUTTON_GAPE:int = 30;
      
      public static var USEBINDPOINT_WITHCHOICE_AUTOLAYOUT_ALERT_STYLE:String = "UseBindPointWithChoiceAutoLayoutAlertStyle";
      
      public static var WITHCHOICE_ALERT_STYLE:String = "WithChoiceAlertStyle";
      
      public static var useStage3D:Boolean;
      
      public static var COMBOX_LIST_LAYER:DisplayObjectContainer;
      
      public static var SCROLL_UINT_INCREMENT:int = 1;
      
      public static var SCROLL_BLOCK_INCREMENT:int = 20;
      
      public static var DISPLACEMENT_OFFSET:uint = 1;
      
      public static var LANGUAGE:String;
      
      public static var REQUEST_PATH:String;
      
      public static var TEMPLATE_PATH:String;
      
      public static var RESOURCE_PATH:String = "";
      
      public static var BACKUP_RESOURCE_PATH:String;
      
      public static var ISFROMHTTPS:Boolean = false;
      
      public static var ResloveConfigXMLPathCall:Function = null;
      
      public static var ResloveConfigZipPathCall:Function = null;
      
      public static var ResloveConfigUISourcePathCall:Function = null;
      
      public static const ALPHA_LAYER_FILTER:String = "alphaLayerGilter";
      
      public static const MD5_FILE_NAME:String = "resouececheck.sq";
      
      public static const CODE_MD5_FILE_NAME:String = "code_md5.dat";
      
      public static const RES_MD5_FILE_NAME:String = "res_md5.dat";
      
      public static const CORE_MODULE_NAME:String = "core.xml";
      
      public static var SITE:String;
      
      public static var LOGIN_RND:Number;
      
      public static var VERTION_PATH:String;
      
      public static const SWITCH_LOWER_CASE:Boolean = true;
      
      public static var storyMoviePathCall:Function;
      
      private static var replaceStr:String = "/";
      
      private static var WRESOURCE_PATH:String = "";
      
      private static var wrpInited:Boolean = false;
      
      public static var COMBOBOX_HIDE_EASE_FUNCTION:Function = Sine.easeIn;
      
      public static var COMBOBOX_SHOW_EASE_FUNCTION:Function = Sine.easeInOut;
      
      public static var MD5_OBJECT:Array = [];
      
      public static var md5Dic:Dictionary = new Dictionary();
      
      public static var checkMD5:Dictionary = new Dictionary();
      
      private static var pattern:RegExp = new RegExp("//","g");
      
      private static var linerPattern:RegExp = /\r/g;
      
      private static var linenPattern:RegExp = /\n/g;
      
      public function ComponentSetting()
      {
         super();
      }
      
      public static function get isZhanQu() : Boolean
      {
         if(ComponentSetting.SITE.slice(0,5) == "baidu" || ComponentSetting.SITE.slice(0,3) == "sky" || ComponentSetting.SITE.slice(0,6) == "banshu")
         {
            return true;
         }
         return false;
      }
      
      public static function get is7road() : Boolean
      {
         return true;
      }
      
      public static function getUISizeXMLPath() : String
      {
         if(DisplayLoader.isDebug)
         {
            return "ui/zh_cn/size.xml";
         }
         return "size.xml";
      }
      
      public static function getUIConfigZIPPath() : String
      {
         if(ResloveConfigZipPathCall == null)
         {
            if(DisplayLoader.isDebug)
            {
               return "ui/" + LANGUAGE + "/xml/xml.png";
            }
            return RESOURCE_PATH + "ui/" + LANGUAGE + "/xml/xml.png";
         }
         return ResloveConfigZipPathCall();
      }
      
      public static function getUISourcePath(param1:String) : String
      {
         if(ResloveConfigUISourcePathCall == null)
         {
            if(DisplayLoader.isDebug)
            {
               return "ui/" + LANGUAGE + "/swf/" + param1 + ".swf";
            }
            return RESOURCE_PATH + "ui/" + LANGUAGE + "/swf/" + param1 + ".swf";
         }
         return ResloveConfigUISourcePathCall(param1);
      }
      
      public static function get LanguagePath() : String
      {
         if(DisplayLoader.isDebug)
         {
            return "ui/" + LANGUAGE + "/" + "language.txt";
         }
         return RESOURCE_PATH + "ui/" + LANGUAGE + "/" + "language.dat";
      }
      
      public static function get NamesLibPath() : String
      {
         if(DisplayLoader.isDebug)
         {
            return "ui/" + LANGUAGE + "/" + "nameslib.txt";
         }
         return RESOURCE_PATH + "ui/" + LANGUAGE + "/" + "nameslib.dat";
      }
      
      public static function get newbieConfigPath() : String
      {
         if(DisplayLoader.isDebug)
         {
            return "ui/" + LANGUAGE + "/" + "newbie.xml";
         }
         return RESOURCE_PATH + "ui/" + LANGUAGE + "/" + "newbie.dat";
      }
      
      public static function get newGuildHelpPath() : String
      {
         if(DisplayLoader.isDebug)
         {
            return "ui/" + LANGUAGE + "/" + "newguildhelp.xml";
         }
         return RESOURCE_PATH + "ui/" + LANGUAGE + "/" + "newguildhelp.dat";
      }
      
      public static function getProjectSourcePath(param1:String) : String
      {
         if(DisplayLoader.isDebug)
         {
            return param1;
         }
         return RESOURCE_PATH + param1;
      }
      
      public static function get ZhanPath() : String
      {
         return TEMPLATE_PATH + "zip_dirty.txt";
      }
      
      public static function get AgentZhanPath() : String
      {
         return TEMPLATE_PATH + "proxy_dirty.txt";
      }
      
      public static function get templatePath() : String
      {
         return TEMPLATE_PATH + "tempinfos.xml";
      }
      
      public static function getOuterCityMapsData(param1:int) : String
      {
         return RESOURCE_PATH + "maps/" + param1 + "/" + param1 + ".maps";
      }
      
      public static function getOuterCityTilesData(param1:int) : String
      {
         return RESOURCE_PATH + "maps/" + param1 + "/" + param1 + ".titles";
      }
      
      public static function mapNameMoviePath(param1:int) : String
      {
         return RESOURCE_PATH + "images/mapName/" + param1 + ".png";
      }
      
      public static function getBattleMapPath(param1:int) : String
      {
         return RESOURCE_PATH + "sceneIma/" + param1 + "/map" + param1 + ".swf";
      }
      
      public static function getStoryMoviePath() : String
      {
         if(storyMoviePathCall != null)
         {
            return storyMoviePathCall();
         }
         return "";
      }
      
      public static function getUrlMd5(param1:String) : String
      {
         var _loc2_:String = getMD5FilePathByUrl(param1);
         if(StringUtils.isEmpty(_loc2_))
         {
            return "";
         }
         var _loc3_:FileVo = getFileVo(_loc2_);
         if(_loc3_ == null)
         {
            return "7road";
         }
         return _loc3_.md5;
      }
      
      public static function getFileVo(param1:String) : FileVo
      {
         if(StringUtils.isEmpty(param1))
         {
            return null;
         }
         var _loc2_:String = getMD5Url(param1);
         return md5Dic[_loc2_];
      }
      
      public static function initWorkedResourcePath() : void
      {
         if(wrpInited)
         {
            return;
         }
         if(RESOURCE_PATH.charAt(RESOURCE_PATH.length - 1) == replaceStr)
         {
            WRESOURCE_PATH = RESOURCE_PATH.substr(0,RESOURCE_PATH.length - 1);
         }
         else
         {
            WRESOURCE_PATH = RESOURCE_PATH.substr(0,RESOURCE_PATH.length);
         }
         wrpInited = true;
      }
      
      public static function getMD5Url(param1:String) : String
      {
         var _loc3_:String = param1;
         var _loc2_:Boolean = false;
         if(_loc3_.search(linerPattern) != -1)
         {
            _loc3_ = _loc3_.replace(linerPattern,"");
         }
         if(_loc3_.search(linenPattern) != -1)
         {
            _loc3_ = _loc3_.replace(linenPattern,"");
         }
         if(_loc3_.search(pattern) == -1)
         {
            return _loc3_;
         }
         if(_loc3_.indexOf(WRESOURCE_PATH) != -1)
         {
            _loc2_ = true;
            _loc3_ = _loc3_.replace(WRESOURCE_PATH,"");
         }
         if(_loc3_.search(pattern) != -1)
         {
            _loc3_ = _loc3_.replace(pattern,replaceStr);
         }
         if(_loc2_)
         {
            _loc3_ = WRESOURCE_PATH + _loc3_;
         }
         return _loc3_;
      }
      
      public static function checkNeedAnalyzeMd5(param1:String) : Boolean
      {
         return MD5_OBJECT.indexOf(param1) >= 0;
      }
      
      public static function getMD5FileNameByFilePath(param1:String) : String
      {
         var _loc2_:String = null;
         param1 = getMD5FilePathByUrl(param1);
         if(param1.indexOf("/") >= 0)
         {
            _loc2_ = param1.substr(param1.lastIndexOf("/") + 1,param1.length);
         }
         else
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public static function getMD5FilePathByUrl(param1:String) : String
      {
         if(param1.indexOf("?") >= 0)
         {
            param1 = param1.substring(0,param1.indexOf("?"));
         }
         return param1.toLowerCase();
      }
      
      public static function compareMD5(param1:ByteArray, param2:String) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param2);
         _loc3_.position = 0;
         param1.position = 5;
         while(_loc3_.bytesAvailable > 0)
         {
            _loc4_ = _loc3_.readByte();
            _loc5_ = param1.readByte();
            if(_loc4_ != _loc5_)
            {
               return false;
            }
         }
         return true;
      }
   }
}

