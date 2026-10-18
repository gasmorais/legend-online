package ancientartifact.mediator
{
   import ancientartifact.view.ArmoryGoodsItemMenu;
   import ancientartifact.view.item.AncientBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.DoubleClickManager;
   import events.AncientArtifactEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class AncientBagCellClickMediator implements IMediator
   {
      
      private var _cell:AncientBagCell;
      
      private var _menu:ArmoryGoodsItemMenu;
      
      public function AncientBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as AncientBagCell;
         if(_cell.iconItem)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.iconItem);
            _cell.iconItem.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.iconItem.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.iconItem)
         {
            DoubleClickManager.Instance.disableDoubleClick(_cell.iconItem);
            _cell.iconItem.removeEventListener("interactive_click",__mouseClickByClicker);
            _cell.iconItem.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell = null;
         }
      }
      
      private function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         var _loc3_:Point = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
         var _loc2_:AncientArmoryInfo = _cell.data;
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data]);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         var _loc2_:String = null;
         if(!_cell || !_cell.data)
         {
            return;
         }
         var _loc3_:int = 0;
         if(model.currentArmoryIndx == 0)
         {
            _loc3_ = noIsQuipPos;
            if(_loc3_ == 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTips02");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_EQUIP,AncientArtifactManager.instance.selectTempId,0,false,_loc3_,_cell.data.armoryId);
         }
         else if(model.currentArmoryIndx == 1)
         {
            model.chooseId = _cell.data.armoryId;
            model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",_cell.data));
            model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
         }
         else if(model.currentArmoryIndx == 2)
         {
            if(!model.isGradeItemInfo)
            {
               if(isArmoryMaxMark(_cell.data.armoryId))
               {
                  model.chooseId = _cell.data.armoryId;
                  model.isGradeItemInfo = true;
                  model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",[_cell.data,-1]));
               }
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips02");
                  MessageTipManager.instance().show(_loc2_);
               }
            }
            else if(!isTheSameProfile(_cell.data.armoryId))
            {
               _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips04");
               MessageTipManager.instance().show(_loc2_);
            }
            else if(isMaxCount())
            {
               model.chooseList.push(_cell.data.armoryId);
               model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",[_cell.data,model.chooseList.length]));
            }
            model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
         }
         else if(model.currentArmoryIndx == 3)
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
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryDeleteTips03");
                     MessageTipManager.instance().show(_loc2_);
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
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryDeleteTips03");
                  MessageTipManager.instance().show(_loc2_);
               }
               model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
            }
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
      
      private function showUseMenu(param1:int, param2:int, param3:AncientBagCell, param4:Boolean) : void
      {
         _menu = ComponentFactory.Instance.creatCustomObject("ancientartifact.ArmoryGoodsItemMenu",[param3,param4]);
         _menu.x = param1;
         _menu.y = param2;
         LayerManager.Instance.addToLayer(_menu,7);
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
      
      private function get noIsQuipPos() : int
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:AncientArtifactInfo = model.getArtifactInfoById(AncientArtifactManager.instance.selectTempId);
         if(!_loc6_)
         {
            return 0;
         }
         var _loc2_:int = 0;
         var _loc5_:Array = [6,1,2,3,4,5];
         var _loc1_:int = int(_loc5_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = int(_loc5_[_loc3_]);
            _loc7_ = int(_loc6_["armoryEquipPos" + _loc2_]);
            if(_loc2_ != 6)
            {
               _loc4_ = int(_loc6_["slotedEquipPos" + _loc2_]);
            }
            else
            {
               _loc4_ = 99;
            }
            if((_loc7_ == 0 || !model.getArmoryInfoById(_loc7_)) && _loc4_ > 0)
            {
               return _loc2_;
            }
            _loc3_ += 1;
         }
         return 0;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
   }
}

