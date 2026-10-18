package cell.mediator.runebag
{
   import cell.mediator.CellDropMediator;
   import cell.view.runebag.RuneIntensifyCell;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class RuneBagCellDropMediator extends CellDropMediator
   {
      
      private var _runeCarryTwoLevel:int = 40;
      
      private var _runeOpenLevel:int = 35;
      
      private var _runeSwallowMax:Number = 1000000000;
      
      public function RuneBagCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{"icon":_loc3_});
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [BaseItemView,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         _runeCarryTwoLevel = int(TempleteManager.instance.getConfigInfoByConfigName("CarryTwoRune").ConfigValue);
         _runeOpenLevel = int(TempleteManager.instance.getConfigInfoByConfigName("OpenRuneGrade").ConfigValue);
         var _loc2_:Array = GoodsManager.instance.getGoodsByBagType(0);
         var _loc6_:int = isRuneIntensifyPoint;
         if(param1.dropTarget is RuneIntensifyCell)
         {
            if(_loc6_ == -1)
            {
               param1.stopImmediatePropagation();
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               return;
            }
            for each(var _loc5_:GoodsInfo in _loc2_)
            {
               _loc4_ += _loc5_.count;
            }
            if(thane.runeInfo.swallowCount < _runeSwallowMax)
            {
               if(!thane.runeInfo.nextTemplateInfo)
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt3");
                  MessageTipManager.instance().show(_loc3_);
               }
               else if(_loc2_.length == 0 || thane.runeInfo.swallowCount + _loc4_ < _runeSwallowMax)
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,_loc6_,1);
               }
               else
               {
                  _loc3_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt5");
                  MessageTipManager.instance().show(_loc3_);
               }
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt1");
               MessageTipManager.instance().show(_loc3_);
            }
            param1.stopImmediatePropagation();
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get isRuneIntensifyPoint() : int
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc3_ = GoodsManager.instance.getHideBagItemByPos(_loc2_);
            if(_loc3_ == null)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command02");
         MessageTipManager.instance().show(_loc1_);
         return -1;
      }
   }
}

