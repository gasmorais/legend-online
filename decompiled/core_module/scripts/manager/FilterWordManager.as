package manager
{
   import com.pickgliss.loader.FilterWordAnalyzer;
   import com.pickgliss.utils.StringUtils;
   import flash.utils.getTimer;
   
   public class FilterWordManager
   {
      
      public static var filterTrim:Boolean;
      
      private static var unableChar:String = "";
      
      private static var REPLACEWORD:String = "~!@#$@#$%~!@#$@#%^&@~!@#$@##$%*~!@#$$@#%^&@~!@#$@#@#";
      
      private static var _hasSetup:Boolean = false;
      
      private static var vCurrent:String = LanguageMgr.GetTranslation("yishi.manager.FilterWordManager.Current");
      
      private static var vConsortiaChannel:String = LanguageMgr.GetTranslation("chatII.datas.getChatChannelName.consortiaChannel");
      
      private static var vTeamChannel:String = LanguageMgr.GetTranslation("chat.datas.getChatChannelName.TEAM");
      
      private static var vPrivateChat:String = LanguageMgr.GetTranslation("chat.view.PrivateChatFrame.title");
      
      private static var vWorldChannel:String = LanguageMgr.GetTranslation("chat.datas.getChatChannelName.SMALLBUGLE");
      
      private static var vBIGBUGLE:String = LanguageMgr.GetTranslation("chat.datas.getChatChannelName.BIGBUGLE");
      
      private static var vOutAreaBigBugle:String = LanguageMgr.GetTranslation("yishi.manager.FilterWordManager.OutAreaBigBugle");
      
      private static var CHANNEL_WORDS:Array = [vCurrent,vConsortiaChannel,vTeamChannel,vPrivateChat,vWorldChannel,vBIGBUGLE,vOutAreaBigBugle];
      
      private static var NICKADDWORDS:Array = [];
      
      private static var WORDS:Array = [];
      
      public function FilterWordManager()
      {
         super();
      }
      
      public static function get hasSetup() : Boolean
      {
         return _hasSetup;
      }
      
      public static function setup(param1:FilterWordAnalyzer) : void
      {
         NICKADDWORDS = param1.nickNames;
         WORDS = param1.words;
         unableChar = param1.unableChar;
         clearnUpNaN_Char(WORDS);
         clearnUpNaN_Char(NICKADDWORDS);
         _hasSetup = true;
      }
      
      private static function clearnUpNaN_Char(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].length == 0)
            {
               param1.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
      }
      
      public static function containUnableChar(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(unableChar.indexOf(param1.charAt(_loc3_)) > -1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function containSpecificChar(param1:String, param2:String) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2.indexOf(param1.charAt(_loc4_)) > -1)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public static function isGotForbiddenWords(param1:String, param2:String = "chat") : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:String = checkFilterTrim(param1.toLocaleLowerCase());
         var _loc4_:uint = WORDS.length;
         if(param2 == "chat")
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(WORDS[_loc5_] != "")
               {
                  if(_loc3_.indexOf(WORDS[_loc5_]) > -1)
                  {
                     return true;
                  }
               }
               _loc5_++;
            }
            _loc4_ = AgentFilterManager.Instance.agentFilter.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(AgentFilterManager.Instance.agentFilter[_loc5_] != "")
               {
                  if(_loc3_.indexOf(AgentFilterManager.Instance.agentFilter[_loc5_]) > -1)
                  {
                     return true;
                  }
               }
               _loc5_++;
            }
         }
         else if(param2 == "name")
         {
            _loc4_ = NICKADDWORDS.length;
            _loc5_ = 0;
            while(true)
            {
               if(_loc5_ < _loc4_)
               {
                  if(_loc3_.indexOf(NICKADDWORDS[_loc5_]) > -1)
                  {
                     break;
                  }
                  _loc5_++;
                  continue;
               }
            }
            return true;
         }
         return false;
      }
      
      private static function formatForbiddenWords(param1:String, param2:Array, param3:Array = null) : String
      {
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Boolean = false;
         var _loc8_:Object = null;
         var _loc5_:String = checkFilterTrim(param1.toLocaleLowerCase());
         var _loc9_:int = int(param2.length);
         var _loc4_:Boolean = false;
         _loc10_ = 0;
         while(_loc10_ < _loc9_)
         {
            if(param2[_loc10_] != "")
            {
               _loc7_ = _loc5_.indexOf(param2[_loc10_]);
               if(_loc7_ > -1)
               {
                  if(_loc5_.substr(_loc7_ - 3,7) != "meranus")
                  {
                     _loc6_ = false;
                     if(param3 != null)
                     {
                        for each(var _loc11_:String in param3)
                        {
                           if(param2[_loc10_].indexOf(_loc11_) >= 0)
                           {
                              _loc6_ = true;
                              break;
                           }
                        }
                     }
                     if(!_loc6_)
                     {
                        _loc4_ = true;
                        _loc8_ = {};
                        _loc8_["word"] = param2[_loc10_];
                        _loc8_["idx"] = _loc5_.indexOf(param2[_loc10_]);
                        _loc8_["length"] = _loc8_["word"].length;
                        _loc5_ = replaceUpperOrLowerCase(_loc5_,_loc8_);
                        param1 = replaceUpperOrLowerCase(param1,_loc8_);
                        _loc10_--;
                     }
                  }
               }
            }
            _loc10_++;
         }
         if(_loc4_ && param1)
         {
            return param1;
         }
         return undefined;
      }
      
      private static function formatChannelWords(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         if(!param1)
         {
            return undefined;
         }
         var _loc5_:int = int(CHANNEL_WORDS.length);
         var _loc2_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = uint(param1.indexOf(CHANNEL_WORDS[_loc6_]));
            _loc4_ = uint(_loc7_ - 1);
            _loc3_ = uint(_loc7_ + CHANNEL_WORDS[_loc6_].length);
            if(_loc7_ > -1)
            {
               if(_loc4_ > -1 && _loc3_ <= param1.length - 1)
               {
                  if(param1.slice(_loc4_,_loc4_ + 1) == "[" && param1.slice(_loc3_,_loc3_ + 1) == "]")
                  {
                     _loc2_ = true;
                     param1 = param1.slice(0,_loc7_) + getXXX(CHANNEL_WORDS[_loc6_].length) + param1.slice(_loc3_);
                  }
               }
            }
            _loc6_++;
         }
         if(_loc2_ && param1)
         {
            return param1;
         }
         return undefined;
      }
      
      private static function replaceUpperOrLowerCase(param1:String, param2:Object) : String
      {
         var _loc3_:String = null;
         var _loc6_:int = int(param2["idx"]);
         var _loc4_:int = int(param2["length"]);
         if(_loc6_ + _loc4_ >= param1.length)
         {
            _loc3_ = param1.slice(_loc6_);
         }
         else
         {
            _loc3_ = param1.slice(_loc6_,_loc6_ + _loc4_);
         }
         var _loc5_:RegExp = new RegExp(_loc3_);
         return param1.replace(_loc5_,getXXX(_loc4_));
      }
      
      public static function filterWrod(param1:String, param2:Array = null) : String
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc3_:int = getTimer();
         var _loc4_:int = 0;
         var _loc5_:String = checkFilterTrim(param1);
         var _loc6_:String = formatChannelWords(_loc5_);
         var _loc7_:Array = WORDS.concat(AgentFilterManager.Instance.agentFilter);
         if(_loc6_)
         {
            _loc8_ = formatForbiddenWords(_loc6_,_loc7_);
         }
         else
         {
            _loc8_ = formatForbiddenWords(_loc5_,_loc7_);
         }
         if(_loc8_)
         {
            _loc9_ = formatForbiddenWords(_loc8_,NICKADDWORDS);
         }
         else if(_loc6_)
         {
            _loc9_ = formatForbiddenWords(_loc6_,NICKADDWORDS);
         }
         else
         {
            _loc9_ = formatForbiddenWords(_loc5_,NICKADDWORDS,param2);
         }
         _loc4_ = getTimer();
         if(_loc9_)
         {
            return _loc9_;
         }
         if(_loc8_)
         {
            return _loc8_;
         }
         if(_loc6_)
         {
            return _loc6_;
         }
         return param1;
      }
      
      public static function IsNullorEmpty(param1:String) : Boolean
      {
         param1 = StringUtils.trim(param1);
         return StringUtils.isNullOrEmpty(param1);
      }
      
      private static function checkFilterTrim(param1:String) : String
      {
         var _loc2_:String = null;
         if(filterTrim)
         {
            _loc2_ = StringUtils.trimAll(param1);
         }
         else
         {
            _loc2_ = StringUtils.trim(param1);
         }
         return _loc2_;
      }
      
      private static function getXXX(param1:int) : String
      {
         var _loc3_:uint = Math.round(Math.random() * (REPLACEWORD.length / 4));
         return REPLACEWORD.slice(_loc3_,_loc3_ + param1);
      }
   }
}

