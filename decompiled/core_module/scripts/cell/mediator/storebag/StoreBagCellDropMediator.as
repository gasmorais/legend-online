package cell.mediator.storebag
{
   import bag.helper.GoodsCheck;
   import cell.mediator.CellDropMediator;
   import cell.view.storebag.StoreCastCell;
   import cell.view.storebag.StoreEnchantCell;
   import cell.view.storebag.StoreIntensifyCell;
   import cell.view.storebag.StoreJewelCell;
   import cell.view.storebag.StoreMountCell;
   import cell.view.storebag.StoreRefreshCell;
   import cell.view.storebag.StoreResolveCell;
   import cell.view.storebag.StoreSwitchCell;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.controler.StoreControler;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.BattleGuardSocketInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class StoreBagCellDropMediator extends CellDropMediator
   {
      
      public function StoreBagCellDropMediator()
      {
         super();
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
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
         _loc2_.dropChecks = [BaseItemView,BaseIconView,Stage];
         _cell.setGrayFilter();
      }
      
      private function addBattleGem(param1:int, param2:int, param3:int, param4:GoodsInfo) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc7_:BattleGuardSocketInfo = thane.battleGuardInfo.getSocketInfo(param1,param2);
         if(_loc7_.itemList[param3] <= 0)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.stoneBagCount <= 0)
            {
               PlayerManager.instance.sendAddBattleGem(param1,param2,param3,param4,1);
            }
            else
            {
               PlayerManager.instance.sendAddBattleGem(param1,param2,param3,param4,34);
            }
         }
         else
         {
            SimpleAlertHelper.instance.data = [addBattleGemBack,param1,param2,param3,param4];
            _loc5_ = LanguageMgr.GetTranslation("public.confirm");
            _loc6_ = LanguageMgr.GetTranslation("public.cancel");
            _loc8_ = LanguageMgr.GetTranslation("public.prompt");
            _loc9_ = LanguageMgr.GetTranslation("wanttoreplace");
            SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc9_,_loc5_,_loc6_);
         }
      }
      
      private function get armyModel() : ArmyModel
      {
         return armyControl.model;
      }
      
      private function get armyControl() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function addBattleGemBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int, param6:GoodsInfo) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.stoneBagCount <= 0)
            {
               PlayerManager.instance.sendAddBattleGem(param3,param4,param5,param6,1);
            }
            else
            {
               PlayerManager.instance.sendAddBattleGem(param3,param4,param5,param6,34);
            }
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var target:BaseItemView;
         var count:int;
         var goods:GoodsInfo;
         var icon:BaseIconView;
         var tempArr:Array;
         var type:int;
         var battleguradPos:int;
         var socketPos:int;
         var str:String;
         var info:GoodsInfo;
         var point:int;
         var moveBagToBag:Function;
         var closeFun:Function;
         var dragObj:GameDrag = param1;
         var goodsTemp:GoodsTemplateInfo = _cell.data.templateInfo;
         if(dragObj.dropTarget is BaseIconView)
         {
            icon = dragObj.dropTarget as BaseIconView;
            if(icon.name && icon.name.indexOf("battleguard") == 0)
            {
               tempArr = icon.name.split("_");
               type = int(tempArr[1]);
               battleguradPos = int(tempArr[2]);
               socketPos = int(tempArr[3]);
               addBattleGem(type,battleguradPos,socketPos,_cell.data);
               dragObj.stopImmediatePropagation();
            }
         }
         else if(dragObj.dropTarget is StoreJewelCell)
         {
            if(GoodsManager.instance.getGoodsByBagType(0).length <= 0)
            {
               str = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellDropMediator.command01");
               MessageTipManager.instance().show(str);
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               return;
            }
            if(StoreJewelCell(dragObj.dropTarget).lock)
            {
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               return;
            }
            if(StoreJewelCell(dragObj.dropTarget).notOpen)
            {
               str = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellDropMediator.command02");
               MessageTipManager.instance().show(str);
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               return;
            }
            if(_cell.data.templateInfo.MasterType == 1 || _cell.data.templateInfo.SonType == 299)
            {
               str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
               MessageTipManager.instance().show(str);
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               return;
            }
            info = GoodsManager.instance.getHideBagItemByPos(0);
            target = dragObj.dropTarget as StoreJewelCell;
            control.mountJewel(_cell.data,StoreJewelCell(target));
            dragObj.stopImmediatePropagation();
         }
         else if(dragObj.dropTarget is StoreMountCell)
         {
            if(_cell.data.templateInfo.MasterType != 1)
            {
               str = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
               MessageTipManager.instance().show(str);
               dragObj.stopImmediatePropagation();
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               return;
            }
            count = dragObj.data > 0 ? dragObj.data : 1;
            target = dragObj.dropTarget as BaseItemView;
            swapItem(_cell,target,count);
            dragObj.stopImmediatePropagation();
         }
         else if(dragObj.dropTarget is StoreResolveCell)
         {
            point = isResolePoint;
            if(point == -1 || point == -2)
            {
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               dragObj.stopImmediatePropagation();
               return;
            }
            moveBagToBag = function():void
            {
               if(!(_cell && _cell.data) || !control.checkSelectResolveItemValid(_cell.data))
               {
                  return;
               }
               PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,point,1);
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
            };
            closeFun = function():void
            {
               if(!(_cell && _cell.data))
               {
                  return;
               }
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
            };
            if(model.selectedPanel == "STORE_PANEL_RESOLVE")
            {
               if(goodsTemp.SonType == 218)
               {
                  control.showResolveAlertForMountCard(moveBagToBag,closeFun);
                  dragObj.stopImmediatePropagation();
                  return;
               }
               if(GoodsCheck.isFashion(goodsTemp))
               {
                  control.showResolveAlertForFashion(moveBagToBag,closeFun);
                  dragObj.stopImmediatePropagation();
                  return;
               }
               if(_cell.data.strengthenGrade > 0)
               {
                  control.showResolveAlert(moveBagToBag,closeFun);
                  dragObj.stopImmediatePropagation();
                  return;
               }
            }
            moveBagToBag();
            dragObj.stopImmediatePropagation();
         }
         else if(dragObj.dropTarget is StoreRefreshCell)
         {
            target = dragObj.dropTarget as BaseItemView;
            count = dragObj.data > 0 ? dragObj.data : 1;
            if(_cell.data.templateInfo.MasterType != 1 && _cell.data.templateInfo.MasterType != 11)
            {
               if(model.selectedPanel == "STORE_PANEL_TREASURE_REFRESH")
               {
                  str = LanguageMgr.GetTranslation("cell.mediator.storebag.treasure.command01");
               }
               else
               {
                  str = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
               }
               MessageTipManager.instance().show(str);
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               dragObj.stopImmediatePropagation();
               return;
            }
            swapItem(_cell,target,count);
            dragObj.stopImmediatePropagation();
         }
         else if(dragObj.dropTarget is StoreCastCell)
         {
            target = dragObj.dropTarget as BaseItemView;
            count = dragObj.data > 0 ? dragObj.data : 1;
            if(_cell.data.templateInfo.MasterType != 1)
            {
               str = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
               MessageTipManager.instance().show(str);
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               dragObj.stopImmediatePropagation();
               return;
            }
            swapItem(_cell,target,count);
            dragObj.stopImmediatePropagation();
         }
         else if(dragObj.dropTarget is StoreSwitchCell)
         {
            if(_cell.data.isLock)
            {
               str = LanguageMgr.GetTranslation("store.view.compose.ComposeMatetialView.sendComposeTip05");
               MessageTipManager.instance().show(str);
               NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
               dragObj.stopImmediatePropagation();
               return;
            }
            count = dragObj.data > 0 ? dragObj.data : 1;
            target = dragObj.dropTarget as BaseItemView;
            swapItem(_cell,target,count);
            dragObj.stopImmediatePropagation();
         }
         else if(dragObj.dropTarget is StoreEnchantCell)
         {
            target = dragObj.dropTarget as StoreEnchantCell;
            if(_cell.data.templateInfo.SonType == 236)
            {
               if((target as StoreEnchantCell).pos == 0)
               {
                  str = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
                  MessageTipManager.instance().show(str);
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                  dragObj.stopImmediatePropagation();
                  return;
               }
               goods = GoodsManager.instance.getItemByPOB(0,0,0);
               if(goods != null && !canEnchant(goods,_cell.data))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command06"));
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                  dragObj.stopImmediatePropagation();
                  return;
               }
            }
            else if(_cell.data.templateInfo.MasterType == 1)
            {
               if((target as StoreEnchantCell).pos == 1)
               {
                  str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
                  MessageTipManager.instance().show(str);
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                  dragObj.stopImmediatePropagation();
                  return;
               }
               goods = GoodsManager.instance.getItemByPOB(1,0,0);
               if(goods != null && !canEnchant(goods,_cell.data))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command06"));
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                  dragObj.stopImmediatePropagation();
                  return;
               }
            }
            count = dragObj.data > 0 ? dragObj.data : 1;
            target = dragObj.dropTarget as BaseItemView;
            swapItem(_cell,target,count);
            dragObj.stopImmediatePropagation();
         }
         else if(dragObj.dropTarget is StoreIntensifyCell)
         {
            target = dragObj.dropTarget as StoreIntensifyCell;
            if(_cell.data.templateInfo.SonType == 204)
            {
               goods = GoodsManager.instance.getItemByPOB(0,0,0);
               if(goods)
               {
                  if(goods.templateInfo.NeedChangeJob == 2)
                  {
                     if(goods.strengthenGrade >= 36)
                     {
                        if(_cell.data.templateInfo.Property2 != 1)
                        {
                           str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
                           MessageTipManager.instance().show(str);
                           NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                           return;
                        }
                     }
                     else if(goods.strengthenGrade < 36)
                     {
                        if(_cell.data.templateInfo.Property2 != 0)
                        {
                           str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
                           MessageTipManager.instance().show(str);
                           NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                           return;
                        }
                     }
                  }
                  else if(goods.templateInfo.NeedChangeJob != 2)
                  {
                     if(_cell.data.templateInfo.Property2 != 0)
                     {
                        str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
                        MessageTipManager.instance().show(str);
                        NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                        return;
                     }
                  }
               }
               if((target as StoreIntensifyCell).sonType == -1 || model.isViceIntensifing)
               {
                  if(model.selectedPanel == "STORE_PANEL_TREASURE_INTENSIFY")
                  {
                     str = LanguageMgr.GetTranslation("cell.mediator.storebag.treasure.command01");
                  }
                  else
                  {
                     str = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
                  }
                  MessageTipManager.instance().show(str);
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                  return;
               }
            }
            else if(_cell.data.templateInfo.MasterType == 1 || _cell.data.templateInfo.MasterType == 11)
            {
               if((target as StoreIntensifyCell).sonType == 204)
               {
                  str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
                  MessageTipManager.instance().show(str);
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
                  dragObj.stopImmediatePropagation();
                  return;
               }
            }
            count = dragObj.data > 0 ? dragObj.data : 1;
            target = dragObj.dropTarget as BaseItemView;
            swapItem(_cell,target,count);
            dragObj.stopImmediatePropagation();
         }
         else
         {
            dragObj.stopImmediatePropagation();
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
      }
      
      private function canEnchant(param1:GoodsInfo, param2:GoodsInfo) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 == null || param2 == null)
         {
            _loc3_ = true;
         }
         else if(param1.templateInfo.Property2 == param2.templateInfo.SonType || param1.templateInfo.SonType == param2.templateInfo.Property2)
         {
            _loc3_ = true;
         }
         else
         {
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      protected function swapItem(param1:BaseItemView, param2:BaseItemView, param3:int) : void
      {
         PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,param2.pos,1);
      }
      
      private function get isResolePoint() : int
      {
         var _loc1_:String = null;
         var _loc2_:GoodsTemplateInfo = _cell.data.templateInfo;
         if(model.selectedPanel == "STORE_PANEL_RESOLVE")
         {
            return control.getGoodsPosForRelove(_cell.data);
         }
         _loc1_ = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
         MessageTipManager.instance().show(_loc1_);
         return -2;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
   }
}

