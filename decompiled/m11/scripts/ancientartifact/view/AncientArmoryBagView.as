package ancientartifact.view
{
   import ancientartifact.view.item.AncientBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.AncientArtifactEvent;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class AncientArmoryBagView extends Component
   {
      
      private var _equipViewList1:SimpleTileList;
      
      private var _equipViewList2:SimpleTileList;
      
      private var _equipScrol1:ScrollPanel;
      
      private var _equipScrol2:ScrollPanel;
      
      private var _defaultCount:int = 16;
      
      private var _equipList:Vector.<AncientBagCell> = new Vector.<AncientBagCell>();
      
      private var _type:int;
      
      public function AncientArmoryBagView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         clearListData();
         _defaultCount = _type == 1 ? 16 : 32;
         if(_type < 2)
         {
            _equipScrol1.visible = true;
            _equipScrol2.visible = false;
            initEquipList1();
         }
         else
         {
            _equipScrol1.visible = false;
            _equipScrol2.visible = true;
            initEquipList2();
         }
         __updataBagInfo(null);
      }
      
      public function initView() : void
      {
         _equipViewList1 = ComponentFactory.Instance.creatCustomObject("ancientArmoryView.equipViewList",[4]);
         _equipViewList2 = ComponentFactory.Instance.creatCustomObject("ancientArmoryView.equipViewList",[4]);
         _equipScrol1 = ComponentFactory.Instance.creatComponentByStylename("ancientArmoryView.equipScrol1");
         _equipScrol2 = ComponentFactory.Instance.creatComponentByStylename("ancientArmoryView.equipScrol2");
         _equipScrol1.setView(_equipViewList1);
         _equipScrol2.setView(_equipViewList2);
         addChild(_equipScrol1);
         addChild(_equipScrol2);
      }
      
      private function clearList() : void
      {
         ObjectUtils.disposeAllChildren(_equipViewList1);
         ObjectUtils.disposeAllChildren(_equipViewList2);
      }
      
      private function initEquipList1() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AncientBagCell = null;
         _equipList = new Vector.<AncientBagCell>();
         _equipViewList1.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _defaultCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ancientArmoryView.StoreBagCell");
            _equipViewList1.addChild(_loc1_);
            _equipList.push(_loc1_);
            _loc2_++;
         }
         _equipViewList1.commitChanges();
         _equipScrol1.invalidateViewport();
      }
      
      private function initEquipList2() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AncientBagCell = null;
         _equipList = new Vector.<AncientBagCell>();
         _equipViewList2.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _defaultCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ancientArmoryView.StoreBagCell");
            _equipViewList2.addChild(_loc1_);
            _equipList.push(_loc1_);
            _loc2_++;
         }
         _equipViewList2.commitChanges();
         _equipScrol2.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         model.addEventListener("ARMORY_BAG_UP_DATA",__updataBagInfo);
         NotificationManager.instance.addEventListener("ARTIFACT_ITEM_CLICK",__updataInfo);
         NotificationManager.instance.addEventListener("ARTIFACT_INFO_UPDATE",__updataInfo);
      }
      
      private function __updataInfo(param1:NotificationEvent) : void
      {
         __updataBagInfo(null);
      }
      
      private function __updataBagInfo(param1:AncientArtifactEvent) : void
      {
         var _loc4_:AncientArmoryInfo = null;
         var _loc2_:AncientBagCell = null;
         var _loc5_:int = 0;
         var _loc6_:Array = getNoChooseBagList();
         var _loc3_:int = int(_loc6_.length);
         if(_loc3_ > _defaultCount)
         {
            clearList();
            _defaultCount = Math.ceil(_loc3_ / 4) * 4;
            if(_type < 2)
            {
               initEquipList1();
            }
            else
            {
               initEquipList2();
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _defaultCount)
         {
            _loc2_ = _equipList[_loc5_];
            _loc4_ = _loc6_[_loc5_];
            if(_loc5_ < _loc3_)
            {
               _loc2_.data = _loc4_;
            }
            else
            {
               _loc2_.data = null;
            }
            _loc5_++;
         }
      }
      
      private function getNoChooseBagList() : Array
      {
         var _loc3_:AncientArmoryInfo = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = model.armorylist;
         var _loc2_:int = int(_loc5_.length);
         var _loc1_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc5_[_loc4_];
            _loc6_ = int(_loc3_.armoryId);
            if(model.currentArmoryIndx == 2)
            {
               if(!isEquip(_loc6_) && isSamePorfileEquip1(_loc6_))
               {
                  _loc1_.push(_loc3_);
               }
            }
            else if(!isEquip(_loc6_) && !isChooseEquip(_loc6_))
            {
               _loc1_.push(_loc3_);
            }
            _loc4_++;
         }
         _loc1_.sortOn(["profile","templateId"],[16,16]);
         _loc1_.reverse();
         return _loc1_;
      }
      
      private function isChooseEquip(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:Array = model.chooseList;
         var _loc3_:int = int(_loc2_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_] == param1)
            {
               return true;
            }
            _loc4_ += 1;
         }
         if(model.chooseId == param1)
         {
            return true;
         }
         return false;
      }
      
      private function isSamePorfileEquip1(param1:int) : Boolean
      {
         var _loc4_:AncientArmoryInfo = null;
         var _loc2_:AncientArmoryInfo = null;
         var _loc3_:UpgradeTemplateInfo = null;
         if(!isChooseEquip(param1))
         {
            _loc4_ = model.getArmoryInfoById(model.chooseId);
            _loc2_ = model.getArmoryInfoById(param1);
            _loc3_ = TempleteManager.instance.getTemplateByTypeAndLevelAndID(_loc2_.grades + 1,138,_loc2_.profile);
            if(!_loc4_)
            {
               if(!_loc3_)
               {
                  return true;
               }
               return false;
            }
            if(_loc4_.templateId == _loc2_.templateId && _loc4_.profile == _loc2_.profile)
            {
               if(!_loc3_)
               {
                  return true;
               }
               return false;
            }
         }
         return false;
      }
      
      private function isEquip(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = int(AncientArtifactManager.instance.selectTempId);
         var _loc5_:AncientArtifactInfo = model.getArtifactInfoById(_loc4_);
         if(_loc5_)
         {
            _loc3_ = 1;
            while(_loc3_ < 7)
            {
               _loc2_ = int(_loc5_["armoryEquipPos" + _loc3_]);
               if(_loc2_ == param1)
               {
                  return true;
               }
               _loc3_ += 1;
            }
         }
         return false;
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("ARMORY_BAG_UP_DATA",__updataBagInfo);
         NotificationManager.instance.removeEventListener("ARTIFACT_ITEM_CLICK",__updataInfo);
         NotificationManager.instance.removeEventListener("ARTIFACT_INFO_UPDATE",__updataInfo);
      }
      
      private function clearListData() : void
      {
         for each(var _loc1_:AncientBagCell in _equipList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _equipList.length = 0;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearListData();
         ObjectUtils.disposeObject(_equipScrol1);
         _equipScrol1 = null;
         ObjectUtils.disposeObject(_equipScrol2);
         _equipScrol2 = null;
         ObjectUtils.disposeObject(_equipViewList1);
         _equipViewList1 = null;
         ObjectUtils.disposeObject(_equipViewList2);
         _equipViewList2 = null;
         _equipList = null;
         super.dispose();
      }
   }
}

