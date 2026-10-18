package map.internals.transaction
{
   import battle.BattleManager;
   import battle.transaction.TransactionBase;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.road.yishi.proto.item.CampaignCardsMsg;
   import map.campaign.CampaignSocketOutManager;
   import map.internals.battle.ChestFrame;
   import yishi.SwitchPageHelp;
   import yishi.datas.BattleModel;
   import yishi.manager.BaseManager;
   import yishi.scene.SceneManager;
   
   public class OpenChestTransaction extends TransactionBase
   {
      
      private var _msg:CampaignCardsMsg;
      
      public function OpenChestTransaction()
      {
         super();
      }
      
      override public function handlePackage() : void
      {
         _msg = new CampaignCardsMsg();
         _msg = _pkg.readBody(_msg) as CampaignCardsMsg;
         var _loc1_:BattleModel = BattleManager.getInstance().battleModel;
         var _loc2_:int = int(_loc1_ ? _loc1_.battleType : -1);
         if(BaseManager.instance.isSelect)
         {
            gotoChest();
         }
         else
         {
            showCardView(_loc2_);
         }
      }
      
      private function showCardView(param1:int) : void
      {
         var _loc3_:String = SceneManager.instance.currentType;
         var _loc2_:ChestFrame = ComponentFactory.Instance.creatCustomObject("core.chest.ChestFrame");
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearGameMenuLayer();
         LayerManager.Instance.getLayerByType(4).visible = false;
         if(!(_loc3_ == "BATTLE_SCENE" && param1 == 16))
         {
            _loc2_.show(_msg);
         }
         _msg = null;
         _loc2_ = null;
      }
      
      override public function getCode() : int
      {
         return 135;
      }
      
      private function gotoChest() : void
      {
         var _loc1_:String = SceneManager.instance.currentType;
         var _loc2_:BattleModel = BattleManager.getInstance().battleModel;
         var _loc3_:int = int(_loc2_ ? _loc2_.battleType : -1);
         if(_loc1_ == "CAMPAIGN_MAP_SCENE")
         {
            CampaignSocketOutManager.instance.sendCampaignFinish(1);
         }
         else if(_loc1_ == "BATTLE_SCENE" && _loc3_ == 16)
         {
            SwitchPageHelp.returnToSpace(null,false,true);
            BattleManager.preScene = "";
         }
         else if(_loc2_ && _loc2_.battleType == 6)
         {
            CampaignSocketOutManager.instance.sendCampaignFinish(1);
         }
      }
   }
}

