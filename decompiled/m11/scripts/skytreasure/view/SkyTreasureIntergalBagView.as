package skytreasure.view
{
   import com.pickgliss.ui.core.Disposeable;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.SkyTreasureManager;
   import yishi.view.community.BaseItemView;
   
   public class SkyTreasureIntergalBagView extends BaseItemView implements Disposeable
   {
      
      private var _boxIndex:int;
      
      public function SkyTreasureIntergalBagView()
      {
         super();
      }
      
      public function get boxIndex() : int
      {
         return _boxIndex;
      }
      
      public function set boxIndex(param1:int) : void
      {
         _boxIndex = param1;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = SkyTreasureManager.Instance.model.chargeRewardsListTemplateIdArray[param1 - 1];
         _loc2_.count = SkyTreasureManager.Instance.model.chargeRewardsListCountArray[param1 - 1];
         this.data = _loc2_;
      }
      
      override public function dispose() : void
      {
      }
   }
}

