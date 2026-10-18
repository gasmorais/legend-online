package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SingleCampaignDataTempInfo;
   
   public class SingleCampaignDataTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SingleCampaignDataTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateAryById(param1:int) : Array
      {
         var _loc3_:SingleCampaignDataTempInfo = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _dic[param1] = [];
               for each(var _loc2_:XML in _list)
               {
                  if(int(_loc2_.@CampaignId) == param1)
                  {
                     _loc3_ = createNode(_loc2_,SingleCampaignDataTempInfo) as SingleCampaignDataTempInfo;
                     _dic[param1].push(_loc3_);
                  }
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTempInfoByIndex(param1:int, param2:int) : SingleCampaignDataTempInfo
      {
         var _loc3_:Array = getTemplateAryById(param1);
         for each(var _loc4_:SingleCampaignDataTempInfo in _loc3_)
         {
            if(_loc4_.Index == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
   }
}

