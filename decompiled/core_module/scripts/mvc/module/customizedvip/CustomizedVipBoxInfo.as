package mvc.module.customizedvip
{
   import managers.CustomizedVipManager;
   import yishi.utils.SimpleDictionary;
   
   public class CustomizedVipBoxInfo
   {
      
      public var type:int;
      
      public var price:int;
      
      public var maxCount:int;
      
      public var customizedItemDic:SimpleDictionary;
      
      public function CustomizedVipBoxInfo()
      {
         super();
         customizedItemDic = new SimpleDictionary();
      }
      
      public function get leftCount() : int
      {
         if(!model.buyCountDic || !model.buyCountDic[type])
         {
            return maxCount;
         }
         return maxCount - model.buyCountDic[type];
      }
      
      private function get model() : CustomizedVipModel
      {
         return CustomizedVipManager.instance.model;
      }
   }
}

