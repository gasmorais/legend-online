package cell.mediator.playerbag
{
   import bag.datas.GoodsSonType;
   import bag.helper.GoodsCheck;
   import cell.mediator.CellDropMediator;
   import cell.mediator.marketbag.MarketItemCell;
   import cell.view.playerbag.PlayerBagCell;
   import cell.view.playerequip.PlayerEquipCell;
   import cell.view.playerequip.RunesCell;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import farm.cell.FarmBagCell;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.IDragTarget;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.GameDrag;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class PlayerBagCellDropMediator extends CellDropMediator
   {
      
      public function PlayerBagCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc2_:Frame = FrameControllerManager.instance.armyController.frame;
         var _loc4_:DisplayObject = getDragIconObj();
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc4_,
            "type":"down"
         });
         _loc3_.data = param1;
         _loc3_.onDrop = beDropHitCallBack;
         _loc3_.dropChecks = [_loc2_["page1"],_loc2_["page2"],_loc2_["page3"],_loc2_["page4"],_loc2_["page5"],_loc2_["page6"],BaseItemView,IDragTarget,Frame,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc8_:BaseItemView = null;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc5_:DisplayObject = null;
         var _loc7_:Point = null;
         _cell.isDraging = false;
         _cell.setNormalFilter();
         var _loc4_:Frame = FrameControllerManager.instance.armyController.frame;
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
               SoundManager.instance.play("003");
               if(param1.dropTarget is FarmBagCell)
               {
                  param1.stopImmediatePropagation();
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
                  return;
               }
               _loc6_ = param1.data > 0 ? param1.data : 1;
               _loc8_ = param1.dropTarget as BaseItemView;
               if(_loc8_.data && GoodsManager.instance.isSellPos(_loc8_.data))
               {
                  return;
               }
               if(_cell.data.templateInfo.MasterType == 5 && param1.dropTarget is PlayerEquipCell)
               {
                  return;
               }
               if(!_loc8_.data || _loc8_.data.templateInfo.SonType != 298)
               {
                  swapItem(_cell,_loc8_,_loc6_);
               }
               param1.stopImmediatePropagation();
            }
            else if(param1.dropTarget is IDragTarget)
            {
               moveToEmptyPos();
            }
            else if(param1.dropTarget is SelectedIconButton)
            {
               SoundManager.instance.play("003");
               _loc3_ = 1;
               if(_loc4_ && _loc4_["currentIndex"] && _loc4_["currentIndex"] == 1)
               {
                  _loc3_ = 34;
               }
               if(_loc4_ && param1.dropTarget == _loc4_["page1"])
               {
                  _loc9_ = GoodsManager.instance.findEmputyPosByPageAndBagType(1,_loc3_);
               }
               else if(_loc4_ && param1.dropTarget == _loc4_["page2"])
               {
                  _loc9_ = GoodsManager.instance.findEmputyPosByPageAndBagType(2,_loc3_);
               }
               else if(_loc4_ && param1.dropTarget == _loc4_["page3"])
               {
                  _loc9_ = GoodsManager.instance.findEmputyPosByPageAndBagType(3,_loc3_);
               }
               else if(_loc4_ && param1.dropTarget == _loc4_["page4"])
               {
                  _loc9_ = GoodsManager.instance.findEmputyPosByPageAndBagType(5,_loc3_);
               }
               else if(_loc4_ && param1.dropTarget == _loc4_["page5"])
               {
                  _loc9_ = GoodsManager.instance.findEmputyPosByPageAndBagType(6,_loc3_);
               }
               else if(_loc4_ && param1.dropTarget == _loc4_["page6"])
               {
                  _loc9_ = GoodsManager.instance.findEmputyPosByPageAndBagType(4,_loc3_);
               }
               if(_loc9_ == -1)
               {
                  _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command01");
                  MessageTipManager.instance().show(_loc2_);
                  _loc5_ = getDragIconObj();
                  _loc5_.width = 42;
                  _loc5_.height = 42;
                  _loc7_ = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
                  _loc5_.x = param1.dragIcon.parent.localToGlobal(new Point(param1.dragIcon.x,param1.dragIcon.y)).x;
                  _loc5_.y = param1.dragIcon.parent.localToGlobal(new Point(param1.dragIcon.x,param1.dragIcon.y)).y;
                  StageReferance.stage.addChild(_loc5_);
                  TweenMax.to(_loc5_,0.5,{
                     "x":_loc7_.x,
                     "y":_loc7_.y,
                     "onComplete":complete,
                     "onCompleteParams":[_loc5_]
                  });
               }
               else if(_loc4_["currentIndex"] == 0)
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,1,0,_loc9_,_cell.data.count);
               }
               else if(_loc4_["currentIndex"] == 1)
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,34,0,_loc9_,_cell.data.count);
               }
            }
            else if(param1.dropTarget is Frame)
            {
               param1.stopImmediatePropagation();
            }
            else if(PlayerManager.instance.newbieProcess > 19000)
            {
               sellItem();
               param1.stopImmediatePropagation();
            }
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
      
      private function complete(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(param1);
      }
      
      protected function sellItem() : void
      {
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc9_:String = null;
         var _loc1_:int = GoodsCheck.getSellGold(_cell.data) * _cell.data.count;
         if(_cell.data.isLock)
         {
            _loc5_ = LanguageMgr.GetTranslation("vicepassword.description2");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         if(_loc1_ == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_cell.data.existJewel())
         {
            if(_cell.data.templateInfo.SonType >= 113 && _cell.data.templateInfo.SonType <= 116)
            {
               _loc2_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.command03");
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.command02");
            }
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_loc1_ + ResourceManager.instance.gold.count >= 2147483647 || _loc1_ + ResourceManager.instance.gold.count < 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("army.itemSellView.sell.overMaxAlert"));
            return;
         }
         SimpleAlertHelper.instance.data = [sellResponse,_cell];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = GoodsSonType.getColorByProfile(_cell.data.templateInfo.Profile);
         var _loc8_:String = _cell.data.templateInfo.TemplateName;
         _loc9_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.content01",_loc6_,_loc8_,_loc1_);
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc9_,_loc3_,_loc4_,false,true);
      }
      
      private function sellResponse(param1:Boolean, param2:Boolean, param3:Object) : void
      {
         if(param1 && param3 && param3.data)
         {
            SocketSendManager.instance.sendSellItem(param3.data.pos,param3.bagType);
         }
      }
      
      protected function swapItem(param1:BaseItemView, param2:BaseItemView, param3:int) : void
      {
         var _loc4_:String = null;
         var _loc5_:GoodsInfo = _cell.data;
         if(!_loc5_)
         {
            return;
         }
         if(param2 is RunesCell)
         {
            if(!checkGoodsByHero())
            {
               return;
            }
            if(!GoodsCheck.isGradeFix(thane,_loc5_.templateInfo,true))
            {
               return;
            }
            if(_loc5_.templateInfo.SonType != 214)
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
            if(GoodsCheck.isFashion(_loc5_.templateInfo))
            {
               return;
            }
            if((param2 as PlayerEquipCell).sonType != _loc5_.templateInfo.SonType)
            {
               if(fashionModel.isFashionBySonType((param2 as PlayerEquipCell).sonType) && !fashionModel.isFashion(param1.data) || !fashionModel.isFashionBySonType((param2 as PlayerEquipCell).sonType) && fashionModel.isFashion(param1.data))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02"));
                  return;
               }
               moveToEmptyPos();
               return;
            }
            if(_cell.data.templateInfo.SonType == 117 || _cell.data.templateInfo.SonType == 118)
            {
               if(_cell.data.templateInfo.NeedChangeJob == 2)
               {
                  if(!thane.isAvenger)
                  {
                     _loc4_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.equipCanJoin2");
                     MessageTipManager.instance().show(_loc4_);
                     return;
                  }
               }
               else if(thane.vocationGrades <= 0)
               {
                  _loc4_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.equipCanJoin");
                  MessageTipManager.instance().show(_loc4_);
                  return;
               }
            }
            if(!checkGoodsByHero())
            {
               return;
            }
            if(!GoodsCheck.isGradeFix(thane,_loc5_.templateInfo,true))
            {
               return;
            }
            PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,param2.pos,param3);
         }
         else if(param2 is PlayerBagCell)
         {
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
      
      private function moveToEmptyPos() : void
      {
         var _loc1_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc2_:Array = null;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         if(!checkGoodsByHero())
         {
            return;
         }
         if(!GoodsCheck.isGradeFix(thane,_cell.data.templateInfo,true))
         {
            return;
         }
         var _loc7_:int = -1;
         if(_cell.data.templateInfo.SonType == 214)
         {
            _loc1_ = GoodsManager.instance.getBattleRunesByTempId(_cell.data.templateId);
            _loc7_ = GoodsManager.instance.getEmputyBattleRunesPos();
            if(_loc1_ && _loc1_.count != _loc1_.templateInfo.MaxCount)
            {
               _loc5_ = _loc1_.templateInfo.MaxCount - _loc1_.count;
               _loc5_ = _cell.data.count > _loc5_ ? _loc5_ : _cell.data.count;
               SoundManager.instance.play("024",true);
               PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,2,thane.id,_loc1_.pos,_loc5_);
            }
            else if(_loc7_ != -1)
            {
               SoundManager.instance.play("024",true);
               PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,2,thane.id,_loc7_,_cell.data.count);
            }
         }
         else
         {
            _loc3_ = GoodsManager.instance.getHeroGoodsListByTypeAndId(_cell.data.templateInfo.MasterType,thane.id).getList();
            _loc2_ = GoodsSonType.getSonTypePos(_cell.data.templateInfo.SonType);
            _loc3_.sortOn("pos");
            _loc8_ = 0;
            if(_loc2_.length > 1)
            {
               _cell.setGrayFilter();
               for each(var _loc6_:GoodsInfo in _loc3_)
               {
                  if(_loc6_.templateInfo.SonType == _cell.data.templateInfo.SonType && _loc6_.pos == _loc2_[0] + _loc8_)
                  {
                     _loc8_++;
                  }
               }
               if(_loc8_ >= _loc2_.length)
               {
                  _loc7_ = int(_loc2_[0]);
               }
               else
               {
                  _loc7_ = int(_loc2_[_loc8_]);
               }
            }
            else
            {
               _loc7_ = int(_loc2_[0]);
            }
            if(_loc7_ != -1)
            {
               SoundManager.instance.play("024",true);
               if(_cell.data.templateInfo.MasterType == 3)
               {
                  _loc4_ = 3;
               }
               else
               {
                  _loc4_ = 4;
               }
               PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,_loc4_,thane.id,_loc7_,1);
            }
         }
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function checkGoodsByHero(param1:Boolean = true) : Boolean
      {
         return GoodsCheck.checkGoodsByHero(_cell.data,thane,param1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

