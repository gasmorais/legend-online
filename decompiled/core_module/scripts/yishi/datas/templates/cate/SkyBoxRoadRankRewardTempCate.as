package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkyBoxRoadRankRewardTempInfo;
   
   public class SkyBoxRoadRankRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function SkyBoxRoadRankRewardTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = int(_loc1_.@Min);
               _loc3_ = int(_loc1_.@Max);
               _loc4_ = _loc2_ + _loc3_;
               if(!_dic[_loc4_])
               {
                  _dic[_loc4_] = [];
               }
               _dic[_loc4_].push(createNode(_loc1_,SkyBoxRoadRankRewardTempInfo));
            }
         }
         return _dic;
      }
   }
}

