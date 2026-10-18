package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.UnrealShootingRewardInfo;
   
   public class UnrealShootingRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function UnrealShootingRewardTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Order;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = [];
               }
               _dic[_loc2_].push(createNode(_loc1_,UnrealShootingRewardInfo));
            }
         }
         return _dic;
      }
   }
}

