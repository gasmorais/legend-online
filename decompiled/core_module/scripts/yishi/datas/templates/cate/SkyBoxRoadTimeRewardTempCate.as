package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkyBoxRoadTimeRewardInfo;
   
   public class SkyBoxRoadTimeRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function SkyBoxRoadTimeRewardTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Index;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,SkyBoxRoadTimeRewardInfo);
               }
            }
         }
         return _dic;
      }
      
      public function getListByCampaignId(param1:int, param2:int = 1) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:SkyBoxRoadTimeRewardInfo in _dic)
         {
            if(_loc4_.CampaignId == param1 && _loc4_.Param2 == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
   }
}

