package bag.view
{
   import cell.view.consortiabag.ConsortiaBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import yishi.manager.GoodsManager;
   import yishi.manager.ViewTempDataManager;
   import yishi.view.community.BaseItemView;
   
   public class GeneralBag extends EquipBagII
   {
      
      public function GeneralBag(param1:int = 7, param2:int = 7, param3:int = 1, param4:int = -2, param5:int = -1)
      {
         bagType = 1;
         ViewTempDataManager.getInstance().castleViewdata.heroUIViewData.curBagType = 1;
         super(param1,param2,param3);
         _list.hSpace = param4;
         _list.vSpace = param5;
      }
      
      override protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:ConsortiaBagCell = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaBagCell");
         _loc3_.bagType = bagType;
         _loc3_.objectId = 0;
         return _loc3_;
      }
      
      override public function refreshData() : void
      {
         _data = GoodsManager.instance.getGeneralBagList();
      }
      
      override public function showEffectBySontype(param1:int) : void
      {
      }
      
      override protected function stopEffect() : void
      {
      }
   }
}

