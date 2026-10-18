package dragontalker.mediator
{
   import com.pickgliss.utils.SoundManager;
   import dragontalker.cell.DragonTalkerTalismanBagCell;
   import dragontalker.cell.DragonTalkerTalismanEquipCell;
   import dragontalker.cell.DragonTalkerTalismanHandleCell;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerBagCellDropMediator implements IMediator
   {
      
      protected var _cell:DragonTalkerTalismanBagCell;
      
      public function DragonTalkerBagCellDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as DragonTalkerTalismanBagCell;
         MsgMan.addObserver("DRAG_ITEM_BagNotic",this,__dragItemBagHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         MsgMan.removeObserver("DRAG_ITEM_BagNotic",this,__dragItemBagHandler);
         _cell = null;
      }
      
      protected function __dragItemBagHandler(param1:String, param2:Object) : void
      {
         if(param2.cell == _cell && !DragManager.getInstance().isDraging)
         {
            starItemDrag(param2.data);
         }
      }
      
      protected function starItemDrag(param1:DragonTalkerTalismanInfo) : void
      {
         SoundManager.instance.play("003");
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{"icon":_loc3_});
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [DragonTalkerTalismanBagCell,DragonTalkerTalismanEquipCell,DragonTalkerTalismanHandleCell,Stage];
         _cell.setGrayFilter();
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc4_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc7_:Matrix = null;
         var _loc5_:Bitmap = null;
         var _loc3_:DragonTalkerTalismanInfo = _cell.data;
         var _loc6_:DisplayObject = _cell.icon;
         if(_loc3_ && _loc6_)
         {
            _loc4_ = new Sprite();
            _loc1_ = _loc6_.getRect(_loc6_);
            _loc2_ = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            _loc7_ = new Matrix();
            _loc7_.translate(-_loc1_.x,-_loc1_.y);
            _loc2_.draw(_loc6_,_loc7_);
            _loc5_ = new Bitmap(_loc2_);
            _loc5_.alpha = 1;
            _loc5_.width = _loc2_.width;
            _loc5_.height = _loc2_.height;
            _loc4_.addChild(_loc5_);
            return _loc4_;
         }
         return null;
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc3_:DragonTalkerTalismanHandleCell = null;
         var _loc4_:DragonTalkerTalismanEquipCell = null;
         var _loc6_:String = null;
         var _loc5_:DragonTalkerTalismanInfo = null;
         var _loc2_:DragonTalkerTalismanInfo = null;
         if(!_cell || !_cell.data || !_cell.data.goodsTempInfo)
         {
            return;
         }
         _cell.setNormalFilter();
         if(param1.dropTarget != _cell)
         {
            if(param1.dropTarget is DragonTalkerTalismanEquipCell)
            {
               _loc4_ = param1.dropTarget as DragonTalkerTalismanEquipCell;
               if(_cell.data.isExpType)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerBagCell.equipNoType.expAlert"));
                  return;
               }
               DragonTalkerManager.instance.sendDragonTalkerTalismanReq(3,_cell.data.id);
            }
            else if(param1.dropTarget is DragonTalkerTalismanHandleCell && model.bagViewType == 2)
            {
               _loc3_ = param1.dropTarget as DragonTalkerTalismanHandleCell;
               if(_loc3_.posType == 1 && Boolean(_cell.data.isExpType))
               {
                  return;
               }
               _loc6_ = _loc3_.cellType + "_" + _loc3_.posType;
               model.hideCellDic.add(_loc6_,_cell.data);
               MsgMan.notifyObserver("HIDE_DIC_CHANGE");
            }
            else if(param1.dropTarget is DragonTalkerTalismanHandleCell && model.bagViewType == 3)
            {
               if(_cell.data.isExpType)
               {
                  return;
               }
               _loc3_ = param1.dropTarget as DragonTalkerTalismanHandleCell;
               if(_loc3_.posType == 1)
               {
                  if(model.hideCellDic["3_2"])
                  {
                     _loc5_ = model.hideCellDic["3_2"];
                     if(_loc5_.goodsTempInfo.SonType != _cell.data.goodsTempInfo.SonType)
                     {
                        model.hideCellDic.del("3_2");
                     }
                  }
                  model.hideCellDic.add("3_1",_cell.data);
                  MsgMan.notifyObserver("HIDE_DIC_CHANGE");
               }
               else if(model.hideCellDic["3_1"])
               {
                  _loc2_ = model.hideCellDic["3_1"];
                  if(_loc2_.goodsTempInfo.SonType != _cell.data.goodsTempInfo.SonType)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerBagCell.swallow.sameTypeAlert"));
                     return;
                  }
                  model.hideCellDic.add("3_2",_cell.data);
                  MsgMan.notifyObserver("HIDE_DIC_CHANGE");
               }
               else
               {
                  model.hideCellDic.add("3_2",_cell.data);
                  MsgMan.notifyObserver("HIDE_DIC_CHANGE");
               }
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
   }
}

