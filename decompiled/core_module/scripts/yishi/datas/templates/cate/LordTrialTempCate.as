package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.LordTrialTempInfo;
   import yishi.utils.StringHelper;
   
   public class LordTrialTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary = new Dictionary();
      
      private var _tempXml:XML;
      
      public function LordTrialTempCate(param1:XMLList)
      {
         super(param1);
      }
      
      public function getTemplateByID(param1:int) : LordTrialTempInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,LordTrialTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,LordTrialTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getItemsByPara1AndPara2(param1:int, param2:int) : String
      {
         var _loc5_:String = null;
         var _loc7_:Array = null;
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc8_:Vector.<LordTrialTempInfo> = getRankRewrad(param1);
         if(_loc8_)
         {
            for each(var _loc6_:LordTrialTempInfo in _loc8_)
            {
               _loc5_ = _loc6_.para2;
               if(_loc5_)
               {
                  _loc7_ = _loc5_.split(",");
                  if(_loc7_ && _loc7_.length == 1)
                  {
                     if(_loc7_[0] == param2)
                     {
                        if(StringHelper.isNullOrEmpty(_loc3_))
                        {
                           _loc3_ = _loc6_.itemId.toString();
                        }
                        else
                        {
                           _loc3_ += "," + _loc6_.itemId;
                        }
                        if(StringHelper.isNullOrEmpty(_loc4_))
                        {
                           _loc4_ = _loc6_.count.toString();
                        }
                        else
                        {
                           _loc4_ += "," + _loc6_.count;
                        }
                     }
                  }
                  else if(_loc7_ && _loc7_.length == 2)
                  {
                     if(_loc7_[0] <= param2 && param2 <= _loc7_[1])
                     {
                        if(StringHelper.isNullOrEmpty(_loc3_))
                        {
                           _loc3_ = _loc6_.itemId.toString();
                        }
                        else
                        {
                           _loc3_ += "," + _loc6_.itemId;
                        }
                        if(StringHelper.isNullOrEmpty(_loc4_))
                        {
                           _loc4_ = _loc6_.count.toString();
                        }
                        else
                        {
                           _loc4_ += "," + _loc6_.count;
                        }
                     }
                  }
               }
            }
         }
         return _loc3_ + "|" + _loc4_;
      }
      
      public function getPrayItems(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc5_:Vector.<LordTrialTempInfo> = getRankRewrad(200);
         if(_loc5_)
         {
            for each(var _loc4_:LordTrialTempInfo in _loc5_)
            {
               if(int(_loc4_.para2) == param1)
               {
                  if(StringHelper.isNullOrEmpty(_loc2_))
                  {
                     _loc2_ = _loc4_.itemId.toString();
                  }
                  else
                  {
                     _loc2_ += "," + _loc4_.itemId;
                  }
                  if(StringHelper.isNullOrEmpty(_loc3_))
                  {
                     _loc3_ = _loc4_.count.toString();
                  }
                  else
                  {
                     _loc3_ += "," + _loc4_.count;
                  }
               }
            }
         }
         return _loc2_ + "|" + _loc3_;
      }
      
      public function getRankRewrad(param1:int) : Vector.<LordTrialTempInfo>
      {
         var _loc3_:Vector.<LordTrialTempInfo> = new Vector.<LordTrialTempInfo>();
         for each(var _loc2_:LordTrialTempInfo in _dic)
         {
            if(_loc2_.para1 == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sort(sortByPara2);
         return _loc3_;
      }
      
      private function sortByPara2(param1:LordTrialTempInfo, param2:LordTrialTempInfo) : int
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1 && param2)
         {
            _loc3_ = param1.para2;
            _loc4_ = param2.para2;
            if(!StringHelper.isNullOrEmpty(_loc3_) && !StringHelper.isNullOrEmpty(_loc4_))
            {
               if(_loc3_.split(",")[0] < _loc4_.split(",")[0])
               {
                  return -1;
               }
               if(_loc3_.split(",")[0] > _loc4_.split(",")[0])
               {
                  return 1;
               }
               return 0;
            }
         }
         return 0;
      }
   }
}

