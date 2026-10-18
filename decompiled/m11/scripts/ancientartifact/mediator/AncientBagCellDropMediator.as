package ancientartifact.mediator
{
   import ancientartifact.view.item.AncientArmoryGradeItem;
   import ancientartifact.view.item.AncientArmoryItem;
   import ancientartifact.view.item.AncientBagCell;
   import ancientartifact.view.item.AncientEquipArmoryItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.SoundManager;
   import events.AncientArtifactEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class AncientBagCellDropMediator implements IMediator
   {
      
      protected var _cell:AncientBagCell;
      
      public function AncientBagCellDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as AncientBagCell;
         NotificationManager.instance.addEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         _cell = null;
      }
      
      protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data[1] && param1.data[0] == _cell && !DragManager.getInstance().isDraging)
         {
            starItemDrag(param1.data[1]);
         }
      }
      
      protected function starItemDrag(param1:AncientArmoryInfo) : void
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
         _loc2_.dropChecks = [AncientArmoryItem,AncientEquipArmoryItem,Stage];
         _cell.setGrayFilter();
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc4_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc7_:Matrix = null;
         var _loc5_:Bitmap = null;
         var _loc3_:AncientArmoryInfo = _cell.data;
         var _loc6_:DisplayObject = _cell.iconItem;
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
         var _loc6_:AncientEquipArmoryItem = null;
         var _loc7_:AncientArmoryInfo = null;
         var _loc3_:String = null;
         var _loc8_:AncientArmoryItem = null;
         var _loc4_:AncientArmoryInfo = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         if(!_cell)
         {
            return;
         }
         _cell.setNormalFilter();
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is AncientEquipArmoryItem)
            {
               _loc6_ = param1.dropTarget as AncientEquipArmoryItem;
               _loc7_ = _loc6_.data;
               if(model.currentArmoryIndx == 0)
               {
                  if(_loc6_.isLock)
                  {
                     _loc3_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryEquipTips03");
                     MessageTipManager.instance().show(_loc3_);
                  }
                  else
                  {
                     AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_EQUIP,AncientArtifactManager.instance.selectTempId,0,false,_loc6_.pos,_cell.data.armoryId);
                  }
               }
               else if(model.currentArmoryIndx == 3)
               {
                  if(!_loc7_)
                  {
                     if(_cell.data.profile > 2)
                     {
                        if(!showArmoryDeleteAlert())
                        {
                           if(model.chooseList.length < 12)
                           {
                              model.chooseList.push(_cell.data.armoryId);
                              model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA"));
                           }
                           model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
                        }
                     }
                     else
                     {
                        if(model.chooseList.length < 12)
                        {
                           model.chooseList.push(_cell.data.armoryId);
                           model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA"));
                        }
                        model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
                     }
                  }
               }
            }
            else if(param1.dropTarget is AncientArmoryItem)
            {
               _loc8_ = param1.dropTarget as AncientArmoryItem;
               _loc4_ = _loc8_.data;
               if(model.currentArmoryIndx == 1 && !_loc4_)
               {
                  model.chooseId = _cell.data.armoryId;
                  model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",_cell.data));
                  model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
               }
               else if(model.currentArmoryIndx == 2)
               {
                  if(_loc8_.parent is AncientArmoryGradeItem && !_loc4_)
                  {
                     if((_loc8_.parent as AncientArmoryGradeItem).type == 1)
                     {
                        if(isArmoryMaxMark(_cell.data.armoryId))
                        {
                           model.chooseId = _cell.data.armoryId;
                           model.isGradeItemInfo = true;
                           model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",[_cell.data,-1]));
                        }
                        else
                        {
                           _loc5_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips02");
                           MessageTipManager.instance().show(_loc5_);
                        }
                     }
                  }
                  else if(model.isGradeItemInfo && isMaxCount())
                  {
                     if(isTheSameProfile(_cell.data.armoryId))
                     {
                        model.chooseList.push(_cell.data.armoryId);
                        model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",[_cell.data,_loc8_.pos]));
                     }
                     else
                     {
                        _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips04");
                        MessageTipManager.instance().show(_loc2_);
                     }
                  }
               }
               model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
               param1.stopImmediatePropagation();
            }
            else
            {
               param1.stopImmediatePropagation();
            }
            param1.stopImmediatePropagation();
         }
      }
      
      private function showArmoryDeleteAlert() : Boolean
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.ancientArmoryDeleteCheckDate;
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc5_:Boolean = Boolean(SharedManager.instance.ancientArmoryDelete);
         if(!_loc5_ || _loc3_.month < _loc4_.month || _loc3_.date < _loc4_.date)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.ArmoryDeleteAlertFrame");
            _loc6_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryDeleteTips02");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc2_,startDeleteAlertBack);
         }
         return _loc1_;
      }
      
      private function startDeleteAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.ancientArmoryDelete = param1;
         SharedManager.instance.ancientArmoryDeleteCheckDate = new Date();
         SharedManager.instance.ancientArmoryDeleteCheck();
         if(model.chooseList.length < 12)
         {
            model.chooseList.push(_cell.data.armoryId);
            model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",[_cell.data,model.chooseList.length]));
         }
         model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
      }
      
      private function isArmoryMaxMark(param1:int) : Boolean
      {
         var _loc2_:AncientArmoryInfo = model.getArmoryInfoById(param1);
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByTypeAndLevelAndID(_loc2_.grades + 1,138,_loc2_.profile);
         if(!_loc3_)
         {
            return true;
         }
         return false;
      }
      
      private function isMaxCount() : Boolean
      {
         var _loc2_:AncientArmoryInfo = model.getArmoryInfoById(model.chooseId);
         var _loc1_:ArmoryTemplateInfo = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_loc2_.templateId,_loc2_.profile + 1);
         if(_loc1_)
         {
            if(model.chooseList.length < _loc1_.ComposeNeedCount)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isTheSameProfile(param1:int) : Boolean
      {
         var _loc2_:AncientArmoryInfo = model.getArmoryInfoById(model.chooseId);
         var _loc3_:AncientArmoryInfo = model.getArmoryInfoById(param1);
         if(_loc2_.templateId == _loc3_.templateId && _loc2_.profile == _loc3_.profile)
         {
            return true;
         }
         return false;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
   }
}

