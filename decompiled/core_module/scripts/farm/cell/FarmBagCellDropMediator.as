package farm.cell
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.SoundManager;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.view.FarmAnimalArea;
   import farm.view.FarmLandItem;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmBagCellDropMediator extends CellDropMediator
   {
      
      private var _stopNextDrag:Boolean = false;
      
      public function FarmBagCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         if(_stopNextDrag)
         {
            _stopNextDrag = false;
            return;
         }
         SoundManager.instance.play("003");
         _cell.isDraging = true;
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
         _loc3_.dropChecks = [FarmLandItem,FarmBagCell,FarmAnimalArea,Stage];
         var _loc2_:Boolean = targetIsAnimal(_loc3_);
         if(_loc2_)
         {
            _loc3_.dropChecks = [FarmLandItem,FarmBagCell,FarmAnimalArea,Stage];
         }
         _cell.setGrayFilter();
         CursorManagerII.instance.hide();
      }
      
      private function targetIsAnimal(param1:GameDrag) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:FarmBagCell = param1.target as FarmBagCell;
         if(_loc3_ == null)
         {
            return _loc2_;
         }
         if(_loc3_.data.templateInfo.SonType == 1500)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      override public function getDragIconObj() : DisplayObject
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.core.cursor.SeedIcon");
         _loc1_.addChild(_loc2_);
         _loc1_.mouseEnabled = _loc1_.mouseChildren = false;
         return _loc1_;
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc4_:int = 0;
         var _loc5_:FarmLandItem = null;
         var _loc3_:FarmAnimalArea = null;
         var _loc2_:int = 0;
         if(param1.dropTarget != _cell)
         {
            if(param1.dropTarget is FarmLandItem)
            {
               _loc4_ = _cell.data.templateInfo.SonType;
               if(_loc4_ == 1500)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.landDrop.droptoanimalarea"));
                  itemDrop(param1);
                  return;
               }
               _loc5_ = param1.dropTarget as FarmLandItem;
               if(!_loc5_.isOpen || !_loc5_.data)
               {
                  itemDrop(param1);
                  return;
               }
               if(_loc5_.data.hasCrop)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.cell.FarmBagCellDropMediator.hasCropTip"));
                  itemDrop(param1);
                  return;
               }
               if(farmManager.checkExistSameSpecialCrop(_cell.data.templateInfo,model.curSelectedFarmInfo))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.cell.FarmBagCellDropMediator.hasSpecialCropTip"));
                  itemDrop(param1);
                  return;
               }
               FarmManager.instance.sendFarmOper(_loc5_.data.userId,1,_loc5_.data.pos,_cell.data.pos,_cell.data.templateId);
               if(int(param1.data) > 1)
               {
                  param1.data = int(param1.data) - 1;
                  param1.stopDropProgress = true;
                  return;
               }
            }
            else if(param1.dropTarget is FarmAnimalArea)
            {
               _loc3_ = param1.dropTarget as FarmAnimalArea;
               _loc4_ = _cell.data.templateInfo.SonType;
               if(_loc4_ != 1500)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.animal.areaerror2"));
                  itemDrop(param1);
                  return;
               }
               _loc2_ = FarmManager.instance.model.myFarm.hasAnimalPosByType(_loc3_.type);
               if(_loc2_ == -1)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.animalArea.fullTips"));
                  itemDrop(param1);
                  return;
               }
               FarmManager.instance.sendFarmOper(param1.dropTarget.userId,1,_loc2_,_cell.data.pos,_cell.data.templateId);
            }
         }
         else
         {
            _stopNextDrag = true;
         }
         itemDrop(param1);
      }
      
      private function itemDrop(param1:GameDrag) : void
      {
         CursorManagerII.instance.resetCursor();
         param1.stopImmediatePropagation();
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get farmManager() : FarmManager
      {
         return FarmManager.instance;
      }
   }
}

