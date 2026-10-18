package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class EclipticPalaceRewardCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function EclipticPalaceRewardCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByType(param1:int, param2:int) : Array
      {
         var _loc4_:Array = [];
         var _loc5_:Dictionary = getTemplates();
         for each(var _loc3_:CommonDropTempInfo in _loc5_)
         {
            if(_loc3_.site == param1 && int(_loc3_.para2) == param2)
            {
               _loc4_.push(_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getEpShowRewards(param1:int, param2:Boolean) : Array
      {
         var _loc4_:Array = [];
         var _loc5_:Dictionary = getTemplates();
         for each(var _loc3_:CommonDropTempInfo in _loc5_)
         {
            if(_loc3_.site == 1)
            {
               if(int(_loc3_.para2) == param1)
               {
                  if(param2 && _loc3_.appearType == 1)
                  {
                     _loc4_.push(_loc3_);
                  }
                  else if(!param2 && _loc3_.appearType != 1)
                  {
                     _loc4_.push(_loc3_);
                  }
               }
            }
         }
         return _loc4_;
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
                  _dic[_loc2_] = createNode(_loc1_,CommonDropTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

