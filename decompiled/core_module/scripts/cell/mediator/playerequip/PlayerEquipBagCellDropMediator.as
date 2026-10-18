package cell.mediator.playerequip
{
   import bag.datas.GoodsSonType;
   import bag.helper.GoodsCheck;
   import bag.view.EquipBagII;
   import cell.mediator.CellDropMediator;
   import cell.mediator.marketbag.MarketItemCell;
   import cell.view.playerbag.PlayerBagCell;
   import cell.view.playerequip.PlayerEquipCell;
   import cell.view.playerequip.RunesCell;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class PlayerEquipBagCellDropMediator extends CellDropMediator
   {
      
      public function PlayerEquipBagCellDropMediator()
      {
         super();
      }
      
      override protected function __itemDropBagHandler(param1:NotificationEvent) : void
      {
         super.__itemDropBagHandler(param1);
         (_cell as PlayerEquipCell).setNormal();
      }
      
      override protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = null;
         var _loc5_:Boolean = false;
         var _loc3_:Boolean = false;
         SoundManager.instance.play("003");
         super.__dragItemBagHandler(param1);
         var _loc4_:BaseItemView = BaseItemView(param1.data[0]);
         if(_loc4_ is PlayerEquipCell)
         {
            return;
         }
         if(_loc4_.data)
         {
            if(!(_loc4_.data.bagType == 1 || _loc4_.data.bagType == 4))
            {
               return;
            }
            _loc2_ = GoodsSonType.getSonTypePos(_loc4_.data.templateInfo.SonType);
            for each(var _loc6_:int in _loc2_)
            {
               if(_loc6_ == _cell.pos && thane)
               {
                  _loc5_ = (_cell as PlayerEquipCell).sonType == _loc4_.data.templateInfo.SonType;
                  _loc3_ = GoodsCheck.isJobFix(thane,_loc4_.data.templateInfo,false);
                  if(_loc5_ && _loc3_ && fashionModel.selectedPanel == "EQUIP_PANEL")
                  {
                     if(_cell.pos < 8)
                     {
                        if((_cell as PlayerEquipCell).bagType == 4)
                        {
                           (_cell as PlayerEquipCell).setFocus();
                        }
                     }
                     else
                     {
                        (_cell as PlayerEquipCell).setFocus();
                     }
                     return;
                  }
               }
            }
         }
         (_cell as PlayerEquipCell).setNormal();
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
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
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [BaseItemView,EquipBagII,Frame,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc8_:* = null;
         var _loc6_:int = 0;
         var _loc4_:PlayerEquipCell = null;
         var _loc7_:PlayerBagCell = null;
         var _loc5_:Boolean = false;
         var _loc2_:String = null;
         _cell.isDraging = false;
         _cell.setNormalFilter();
         var _loc3_:Frame = FrameControllerManager.instance.armyController.frame;
         if(param1.dropTarget is MarketItemCell)
         {
            param1.stopImmediatePropagation();
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
            return;
         }
         if(param1.dropTarget != _cell)
         {
            if(param1.dropTarget is BaseItemView)
            {
               if(param1.dropTarget is PlayerEquipCell)
               {
                  _loc4_ = param1.dropTarget as PlayerEquipCell;
                  if(_loc4_.sonType == (_cell as PlayerEquipCell).sonType)
                  {
                     swapItem(_cell,_loc4_,_cell.data.count);
                  }
               }
               else if(param1.dropTarget is PlayerBagCell)
               {
                  _loc7_ = param1.dropTarget as PlayerBagCell;
                  _loc5_ = GoodsCheck.checkGoodsCanEquip(_loc7_.data,thane);
                  if(!_loc7_.data || _loc5_ && _loc7_.data.templateInfo.SonType == (_cell as PlayerEquipCell).sonType && _loc7_.data && !GoodsManager.instance.isSellPos(_loc7_.data))
                  {
                     swapItem(_cell,_loc7_,_cell.data.count);
                  }
                  else if(GoodsManager.instance.findEmputyPos() > 0)
                  {
                     moveToEmptyPos();
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerEquipBagCellDropMediator.command01");
                     MessageTipManager.instance().show(_loc2_);
                  }
               }
            }
            else if(param1.dropTarget is EquipBagII)
            {
               moveToEmptyPos();
               param1.stopImmediatePropagation();
            }
            else if(param1.dropTarget is Frame)
            {
               param1.stopImmediatePropagation();
            }
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
      
      protected function moveToEmptyPos() : void
      {
         var _loc2_:String = null;
         var _loc4_:Frame = FrameControllerManager.instance.armyController.frame;
         var _loc3_:int = 1;
         var _loc1_:int = GoodsManager.instance.findEmputyPos();
         if(_loc4_ && _loc4_["currentIndex"] && _loc4_["currentIndex"] == 1)
         {
            _loc1_ = GoodsManager.instance.findStroeEmputyPos();
            _loc3_ = 34;
         }
         if(_loc1_ == -1)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SoundManager.instance.play("024",true);
         _cell.setGrayFilter();
         PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,_loc3_,0,_loc1_,1);
      }
      
      protected function swapItem(param1:BaseItemView, param2:BaseItemView, param3:int) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:GoodsInfo = _cell.data;
         if(param2 is RunesCell)
         {
            if(_loc6_.templateInfo.SonType != 214)
            {
               _loc4_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
            if((param2 as RunesCell).lock)
            {
               return;
            }
            PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,param2.pos,param3);
         }
         else if(param2 is PlayerEquipCell)
         {
            if((param2 as PlayerEquipCell).sonType != (_cell as PlayerEquipCell).sonType)
            {
               return;
            }
            SoundManager.instance.play("024",true);
            PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,param2.pos,param3);
         }
         else if(param2 is PlayerBagCell)
         {
            SoundManager.instance.play("024",true);
            if(param2.data)
            {
               if(param2.data.templateInfo.SonType != _loc6_.templateInfo.SonType || !(param2 as PlayerBagCell).checkGoodsByHero())
               {
                  _loc5_ = GoodsManager.instance.findEmputyPos();
                  PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,_loc5_,param3);
                  return;
               }
            }
            PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,param2.pos,param3);
         }
      }
      
      private function startMoveBagToBag(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            PlayerManager.instance.moveBagToBag(param3[0],param3[1],param3[2],param3[3],param3[4],param3[5],param3[6]);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

