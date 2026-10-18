package star.view
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.StarEvent;
   import flash.display.Sprite;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.manager.TaskManage;
   import yishi.utils.StarHelper;
   
   public class EquipStarListView extends Sprite implements Disposeable
   {
      
      public static const EQUIP_STAR_BAG_COUNT:int = 10;
      
      private static const STAR_MASTER_TASK:int = 1802;
      
      private var _area:Sprite;
      
      private var _itemList:Vector.<StarBagCell>;
      
      private var _effect:MainToolBtnGlowEffect;
      
      public function EquipStarListView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:StarBagCell = null;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:String = null;
         _area = new Sprite();
         _area.graphics.beginFill(16777215,0);
         _area.graphics.drawRect(-36,-67,380,420);
         _area.graphics.endFill();
         addChild(_area);
         _itemList = new Vector.<StarBagCell>();
         var _loc12_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell1");
         var _loc11_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell2");
         var _loc14_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell3");
         var _loc13_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell4");
         var _loc8_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell5");
         var _loc7_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell6");
         var _loc10_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell7");
         var _loc9_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell8");
         var _loc6_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell9");
         var _loc3_:StarBagCell = ComponentFactory.Instance.creatCustomObject("star.EquipStarBagCell10");
         _itemList.push(_loc12_);
         _itemList.push(_loc11_);
         _itemList.push(_loc14_);
         _itemList.push(_loc13_);
         _itemList.push(_loc8_);
         _itemList.push(_loc7_);
         _itemList.push(_loc10_);
         _itemList.push(_loc9_);
         _itemList.push(_loc6_);
         _itemList.push(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.acceptDrop = true;
            _loc1_.troughInfo = StarManager.instance.getStarTroughInfoByPos(_loc2_);
            _loc1_.data = StarManager.instance.getStarInfoByBagTypeAndPos(2,_loc2_);
            _loc1_.bagType = 2;
            _loc1_.backVisible = false;
            _loc1_.bagPos = _loc2_;
            if(_loc2_ < 8)
            {
               if(_loc2_ < int(thane.grades / 10))
               {
                  _loc1_.lock = false;
                  if(_loc2_ < playerInfo.vocationLevel)
                  {
                     _loc1_.btnState = true;
                  }
                  else
                  {
                     _loc1_.btnState = false;
                  }
               }
               else
               {
                  _loc1_.lock = true;
                  _loc1_.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.runes",String(10 * (_loc2_ + 1)));
               }
            }
            else if(_loc2_ == 8)
            {
               if(TaskManage.instance.IsTaskFinish(1802) && ArmyManager.instance.thane.grades >= 60)
               {
                  if(_loc1_.troughInfo.isFirstOpen)
                  {
                     _loc1_.addGlowFilter();
                     _loc1_.backVisible = false;
                     _loc1_.troughInfo.isFirstOpen = false;
                  }
                  else
                  {
                     _loc1_.lock = false;
                     _loc1_.btnState = false;
                  }
               }
               else
               {
                  _loc1_.lock = true;
                  _loc5_ = LanguageMgr.GetTranslation("star.view.EquipStarListView.promptStr01",StarHelper.getThirdJobStr());
                  _loc1_.tipData = _loc5_;
               }
            }
            else if(_loc2_ == 9)
            {
               if(TaskManage.instance.IsTaskFinish(1802) && playerInfo.vocationLevel > 0)
               {
                  _loc1_.lock = false;
               }
               else
               {
                  _loc1_.lock = true;
                  _loc4_ = LanguageMgr.GetTranslation("star.view.EquipStarListView.promptStr02",StarHelper.getThirdJobStr());
                  _loc1_.tipData = _loc4_;
               }
            }
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function __refreshStarTroughInfo(param1:NotificationEvent) : void
      {
         var _loc2_:StarBagCell = null;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc5_:String = null;
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc2_ = _itemList[_loc4_];
            _loc2_.troughInfo = StarManager.instance.getStarTroughInfoByPos(_loc4_);
            if(_loc4_ < 8)
            {
               if(_loc4_ < int(thane.grades / 10))
               {
                  _loc2_.lock = false;
                  if(_loc4_ < playerInfo.vocationLevel)
                  {
                     _loc2_.btnState = true;
                  }
                  else
                  {
                     _loc2_.btnState = false;
                  }
               }
               else
               {
                  _loc2_.lock = true;
                  _loc2_.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.runes",String(10 * (_loc4_ + 1)));
               }
            }
            else if(_loc4_ == 8)
            {
               if(TaskManage.instance.IsTaskFinish(1802) && ArmyManager.instance.thane.grades >= 60)
               {
                  if(_loc2_.troughInfo.isFirstOpen)
                  {
                     _loc2_.addGlowFilter();
                     _loc2_.backVisible = false;
                     _loc2_.troughInfo.isFirstOpen = false;
                  }
                  else
                  {
                     _loc2_.lock = false;
                     _loc2_.btnState = false;
                  }
               }
               else
               {
                  _loc2_.lock = true;
                  _loc3_ = LanguageMgr.GetTranslation("star.view.EquipStarListView.promptStr01");
                  _loc2_.tipData = _loc3_;
               }
            }
            else if(_loc4_ == 9)
            {
               if(TaskManage.instance.IsTaskFinish(1802) && playerInfo.vocationLevel > 0)
               {
                  _loc2_.lock = false;
               }
               else
               {
                  _loc2_.lock = true;
                  _loc5_ = LanguageMgr.GetTranslation("star.view.EquipStarListView.promptStr02",StarHelper.getThirdJobStr());
                  _loc2_.tipData = _loc5_;
               }
            }
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         StarManager.instance.addEventListener("UPDATE_STAR",__updateHandler);
         StarManager.instance.addEventListener("DELETE_STAR",__deleteHandler);
         NotificationManager.instance.addEventListener("REFRESH_STARTROUGHINFO",__refreshStarTroughInfo);
      }
      
      private function removeEvent() : void
      {
         StarManager.instance.removeEventListener("UPDATE_STAR",__updateHandler);
         StarManager.instance.removeEventListener("DELETE_STAR",__deleteHandler);
         NotificationManager.instance.removeEventListener("REFRESH_STARTROUGHINFO",__refreshStarTroughInfo);
      }
      
      private function __updateHandler(param1:StarEvent) : void
      {
         var _loc2_:StarBagCell = null;
         var _loc3_:StarInfo = param1.starInfo;
         if(_loc3_.bagType == 2)
         {
            _loc2_ = _itemList[_loc3_.pos] as StarBagCell;
            if(_loc2_)
            {
               _loc2_.data = _loc3_;
            }
         }
      }
      
      private function __deleteHandler(param1:StarEvent) : void
      {
         var _loc2_:StarBagCell = null;
         var _loc3_:StarInfo = param1.starInfo;
         if(_loc3_.bagType == 2)
         {
            _loc2_ = _itemList[_loc3_.pos] as StarBagCell;
            if(_loc2_)
            {
               _loc2_.data = null;
            }
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         DragManager.getInstance().stopDrag();
         for each(var _loc1_:StarBagCell in _itemList)
         {
            _loc1_.tipData = "";
            _loc1_.dispose();
            _loc1_ = null;
         }
         _itemList = null;
         ObjectUtils.disposeViolentMc(_area);
         _area = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

