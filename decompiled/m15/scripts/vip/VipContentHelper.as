package vip
{
   import yishi.datas.templates.VipPrerogativeInfo;
   import yishi.manager.TempleteManager;
   
   public class VipContentHelper
   {
      
      public function VipContentHelper()
      {
         super();
      }
      
      public static function getnumByGrade(param1:int, param2:int = 2) : int
      {
         var _loc4_:VipPrerogativeInfo = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getTemplatesByGrade(param1);
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc6_] as VipPrerogativeInfo;
            if(int(_loc4_.para1) != 0)
            {
               _loc5_++;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public static function getContentByGrade(param1:int, param2:int = 2) : String
      {
         var _loc6_:VipPrerogativeInfo = null;
         var _loc5_:String = null;
         var _loc8_:String = null;
         var _loc7_:int = 0;
         var _loc3_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getTemplatesByGrade(param1);
         var _loc4_:String = "<br/>";
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc7_] as VipPrerogativeInfo;
            if(int(_loc6_.para1) != 0)
            {
               if(int(_loc6_.para3) == 1)
               {
                  _loc5_ = "<font color=\'#60d5f7\'>" + getTranslation(_loc6_.name,_loc6_) + "</font>";
               }
               else
               {
                  _loc5_ = getTranslation(_loc6_.name,_loc6_);
               }
               if(param2 == 2)
               {
                  _loc8_ = _loc7_ != _loc3_.length - 1 ? "<br/><br/>" : "";
                  _loc4_ += _loc5_ + _loc8_;
               }
               else
               {
                  _loc8_ = _loc7_ != _loc3_.length - 1 ? "<br/><br/><br/>" : "";
                  _loc4_ += _loc5_ + _loc8_;
               }
            }
            _loc7_++;
         }
         return _loc4_;
      }
      
      private static function getTranslation(param1:String, param2:VipPrerogativeInfo) : String
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc4_:int = param1.indexOf("{");
         if(_loc4_ == -1)
         {
            return param1;
         }
         var _loc7_:int = param1.indexOf("}");
         var _loc3_:String = "";
         while(_loc4_ != -1)
         {
            _loc5_ = param1.substring(_loc4_ + 1,_loc7_);
            _loc6_ = getReplayStr(_loc5_,param2);
            _loc3_ += param1.substring(0,_loc4_) + _loc6_;
            _loc8_ = param1 = param1.substr(_loc7_ + 1);
            _loc4_ = _loc8_.indexOf("{");
            _loc7_ = _loc8_.indexOf("}");
            if(_loc4_ == -1)
            {
               _loc3_ += _loc8_;
            }
         }
         return _loc3_;
      }
      
      private static function getReplayStr(param1:String, param2:VipPrerogativeInfo) : String
      {
         if(param1.indexOf("para1") != -1)
         {
            return String(param2.para1);
         }
         if(param1.indexOf("para2") != -1)
         {
            return String(param2.para2);
         }
         return "0";
      }
   }
}

