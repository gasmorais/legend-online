package dragontalker.mediator
{
   import com.pickgliss.utils.SoundManager;
   import dragontalker.cell.DragonTalkerTalismanBagCell;
   import dragontalker.cell.DragonTalkerTalismanHandleCell;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.MsgMan;
   
   public class DragonTalkerHandleCellDropMediator implements IMediator
   {
      
      protected var _cell:DragonTalkerTalismanHandleCell;
      
      public function DragonTalkerHandleCellDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as DragonTalkerTalismanHandleCell;
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
         _loc2_.dropChecks = [DragonTalkerTalismanBagCell,DragonTalkerTalismanHandleCell,Stage];
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
         var _loc4_:DragonTalkerTalismanBagCell = null;
         var _loc2_:DragonTalkerTalismanHandleCell = null;
         var _loc3_:DragonTalkerTalismanInfo = null;
         if(!_cell || !_cell.data || !_cell.data.goodsTempInfo)
         {
            return;
         }
         _cell.setNormalFilter();
         if(param1.dropTarget != _cell)
         {
            if(param1.dropTarget is DragonTalkerTalismanBagCell)
            {
               _loc4_ = param1.dropTarget as DragonTalkerTalismanBagCell;
               model.hideCellDic.del(_cell.cellType + "_" + _cell.posType);
               MsgMan.notifyObserver("HIDE_DIC_CHANGE");
            }
            else if(param1.dropTarget is DragonTalkerTalismanHandleCell)
            {
               _loc2_ = param1.dropTarget as DragonTalkerTalismanHandleCell;
               _loc3_ = _loc2_.data;
               if(_loc3_)
               {
                  model.hideCellDic.clear();
                  if(_loc3_.isExpType)
                  {
                     model.hideCellDic.add(_loc2_.cellType + "_" + _loc2_.posType,_cell.data);
                  }
                  else if(_cell.data.isExpType)
                  {
                     model.hideCellDic.add(_cell.cellType + "_" + _cell.posType,_loc3_);
                  }
                  else
                  {
                     model.hideCellDic.add(_cell.cellType + "_" + _cell.posType,_loc3_);
                     model.hideCellDic.add(_loc2_.cellType + "_" + _loc2_.posType,_cell.data);
                  }
               }
               else
               {
                  model.hideCellDic.clear();
                  model.hideCellDic.add(_loc2_.cellType + "_" + _loc2_.posType,_cell.data);
               }
               MsgMan.notifyObserver("HIDE_DIC_CHANGE");
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

