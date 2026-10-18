package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MinosRewardTempInfo;
   
   public class MinosRewardCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function MinosRewardCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,MinosRewardTempInfo);
               }
            }
         }
         _loc2_ = null;
      }
      
      public function getTemplateByID(param1:int) : MinosRewardTempInfo
      {
         return _dic["" + param1];
      }
      
      public function getTempListBy(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:MinosRewardTempInfo in _dic)
         {
            if(_loc3_.RewardType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("Id",16);
         return _loc2_;
      }
   }
}

