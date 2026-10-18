package cell.mediator.consortiabag
{
   import cell.mediator.CellDropMediator;
   import cell.view.consortiabag.ConsortiaCaseCell;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaCaseCellDropMediator extends CellDropMediator
   {
      
      public function ConsortiaCaseCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         var _loc2_:* = FrameControllerManager.instance.consortiaController.model.bagView;
         var _loc4_:DisplayObject = getDragIconObj();
         if(!_loc4_)
         {
            return;
         }
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc3_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc4_,
            "type":"down"
         });
         _loc3_.data = param1;
         _loc3_.onDrop = beDropHitCallBack;
         _loc3_.dropChecks = [_loc2_["page1"],_loc2_["page2"],_loc2_["page3"],_loc2_["page4"],_loc2_["page5"],BaseItemView,Frame,Stage];
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
         var _loc4_:* = FrameControllerManager.instance.consortiaController.model.bagView;
         if(param1.dropTarget != _cell)
         {
            if(param1.dropTarget is BaseItemView)
            {
               if(param1.dropTarget is ConsortiaCaseCell && param1.dropTarget.isLock)
               {
                  param1.stopImmediatePropagation();
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
                  return;
               }
               _loc6_ = param1.data > 0 ? param1.data : 1;
               _loc8_ = param1.dropTarget as BaseItemView;
               if(_loc8_.data && _loc8_.data.templateInfo.SonType == 298)
               {
                  param1.stopImmediatePropagation();
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
                  return;
               }
               if(_loc8_.data && GoodsManager.instance.isSellPos(_loc8_.data) && _loc8_.data.bagType == 1)
               {
                  NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
                  return;
               }
               swapItem(_cell,_loc8_,_loc6_);
               param1.stopImmediatePropagation();
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
                  _loc9_ = GoodsManager.instance.findEmputyPosByPageAndBagType(4,_loc3_);
               }
               else if(_loc4_ && param1.dropTarget == _loc4_["page5"])
               {
                  _loc9_ = GoodsManager.instance.findEmputyPosByPageAndBagType(5,_loc3_);
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
            else
            {
               param1.stopImmediatePropagation();
            }
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
      
      private function complete(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(param1);
      }
      
      protected function swapItem(param1:BaseItemView, param2:BaseItemView, param3:int) : void
      {
         PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,param2.pos,param3);
      }
      
      private function startMoveBagToBag(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            PlayerManager.instance.moveBagToBag(param3[0],param3[1],param3[2],param3[3],param3[4],param3[5],param3[6]);
         }
      }
   }
}

