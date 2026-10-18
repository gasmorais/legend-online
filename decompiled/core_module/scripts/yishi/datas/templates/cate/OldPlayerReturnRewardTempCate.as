package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.OldPlayerReturnRewardTempInfo;
   
   public class OldPlayerReturnRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function OldPlayerReturnRewardTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,OldPlayerReturnRewardTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTempInfoById(param1:int) : OldPlayerReturnRewardTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:OldPlayerReturnRewardTempInfo in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getCountByType(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:Dictionary = getTemplates();
         for each(var _loc3_:OldPlayerReturnRewardTempInfo in _loc4_)
         {
            if(_loc3_.RewardType == param1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function getTempInfoByType(param1:int, param2:int) : OldPlayerReturnRewardTempInfo
      {
         var _loc4_:Dictionary = getTemplates();
         for each(var _loc3_:OldPlayerReturnRewardTempInfo in _loc4_)
         {
            if(_loc3_.RewardType == param1 && _loc3_.RewardNum == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

