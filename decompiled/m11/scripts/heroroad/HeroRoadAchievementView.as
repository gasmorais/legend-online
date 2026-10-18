package heroroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.module.heroroad.AchievementTaskInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.NotificationManager;
   
   public class HeroRoadAchievementView extends Sprite implements Disposeable
   {
      
      private var _back:DisplayObject;
      
      private var _allAchievementBtn:SelectedIconButton;
      
      private var _roleAchievementBtn:SelectedIconButton;
      
      private var _transcriptAchievementBtn:SelectedIconButton;
      
      private var _competitiveAchievementBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      private var _group:SelectedButtonGroup;
      
      private var _vbox:VBox;
      
      private var _scollPanel:ScrollPanel;
      
      private var _dataArray:Array;
      
      private var _createTimeId:int;
      
      public function HeroRoadAchievementView()
      {
         super();
         HeroRoadManager.instance.achivementOpenFrame();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadAchievementView.back");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadAchievementView.btnHbox");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadAchievementView.vbox");
         _scollPanel = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadAchievementView.scollPanel");
         _allAchievementBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.allAchievementBtn");
         _roleAchievementBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.roleAchievementBtn");
         _transcriptAchievementBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.transcriptAchievementBtn");
         _competitiveAchievementBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.competitiveAchievementBtn");
         addChild(_back);
         addChild(_btnHbox);
         addChild(_scollPanel);
         _scollPanel.setView(_vbox);
         _group = new SelectedButtonGroup();
         _btnHbox.addChild(_allAchievementBtn);
         _btnHbox.addChild(_roleAchievementBtn);
         _btnHbox.addChild(_transcriptAchievementBtn);
         _btnHbox.addChild(_competitiveAchievementBtn);
         _group.addSelectItem(_allAchievementBtn);
         _group.addSelectItem(_roleAchievementBtn);
         _group.addSelectItem(_transcriptAchievementBtn);
         _group.addSelectItem(_competitiveAchievementBtn);
         _group.selectIndex = 0;
      }
      
      private function refreshData(param1:Array) : void
      {
         var _loc2_:HeroRoadAchievementItemView = null;
         var _loc4_:int = 0;
         if(_vbox)
         {
            _vbox.disposeAllChildren();
         }
         if(!param1 || param1.length == 0)
         {
            return;
         }
         _scollPanel.beginChanges();
         var _loc3_:int = int(param1.length);
         if(_loc3_ > 30)
         {
            _loc4_ = 0;
            while(_loc4_ < 30)
            {
               _loc2_ = new HeroRoadAchievementItemView();
               _loc2_.data = param1[_loc4_] as AchievementTaskInfo;
               _vbox.addChild(_loc2_);
               if(_loc4_ == 29)
               {
                  hideSearchBox();
               }
               _loc4_++;
            }
            _scollPanel.commitChanges();
            _scollPanel.invalidateViewport();
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = new HeroRoadAchievementItemView();
               _loc2_.data = param1[_loc4_] as AchievementTaskInfo;
               _vbox.addChild(_loc2_);
               _loc4_++;
            }
            _scollPanel.commitChanges();
            _scollPanel.invalidateViewport();
         }
      }
      
      private function hideSearchBox() : void
      {
         var _loc1_:HeroRoadAchievementItemView = null;
         var _loc3_:int = 0;
         if(!_dataArray)
         {
            return;
         }
         var _loc2_:int = int(_dataArray.length);
         _loc3_ = 30;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new HeroRoadAchievementItemView();
            _loc1_.data = _dataArray[_loc3_] as AchievementTaskInfo;
            if(_vbox)
            {
               _vbox.addChild(_loc1_);
            }
            _loc3_++;
         }
         if(_scollPanel)
         {
            _scollPanel.commitChanges();
            _scollPanel.invalidateViewport();
         }
      }
      
      private function addEvent() : void
      {
         _group.addEventListener("change",__panelChangeHandler);
         NotificationManager.instance.addEventListener("HEROROAD_ACHIEVEMENT_LIST_UPDATE",__updateViewHandler);
         NotificationManager.instance.addEventListener("HEROROAD_ACHIEVEMENT_ITEM_UPDATE",__updateItemHandler);
      }
      
      private function removeEvent() : void
      {
         _group.removeEventListener("change",__panelChangeHandler);
         NotificationManager.instance.removeEventListener("HEROROAD_ACHIEVEMENT_LIST_UPDATE",__updateViewHandler);
         NotificationManager.instance.removeEventListener("HEROROAD_ACHIEVEMENT_ITEM_UPDATE",__updateItemHandler);
      }
      
      private function __updateItemHandler(param1:NotificationEvent) : void
      {
         var _loc2_:HeroRoadAchievementItemView = null;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         if(_group.selectIndex == 0)
         {
            _dataArray = HeroRoadManager.instance.getAllAchievemtnItems();
         }
         else
         {
            _dataArray = HeroRoadManager.instance.getAchievemtnItemsByClassify(_group.selectIndex);
         }
         if(!_dataArray || _dataArray.length == 0)
         {
            return;
         }
         _scollPanel.beginChanges();
         var _loc3_:int = int(_dataArray.length);
         var _loc7_:int = int(_vbox.numChildren);
         var _loc5_:int = int(_dataArray.length);
         if(_loc5_ > _loc7_)
         {
            _loc6_ = 0;
            while(_loc6_ < _vbox.numChildren)
            {
               _loc2_ = _vbox.getChildAt(_loc6_) as HeroRoadAchievementItemView;
               _loc2_.data = _dataArray[_loc6_] as AchievementTaskInfo;
               _loc6_++;
            }
            _loc6_ = 0;
            while(_loc6_ < _loc5_ - _loc7_)
            {
               _loc2_ = new HeroRoadAchievementItemView();
               _loc2_.data = _dataArray[_loc6_ + _loc7_] as AchievementTaskInfo;
               _vbox.addChild(_loc2_);
               _loc6_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < _vbox.numChildren)
            {
               _loc2_ = _vbox.getChildAt(_loc6_) as HeroRoadAchievementItemView;
               _loc2_.data = _dataArray[_loc6_] as AchievementTaskInfo;
               _loc6_++;
            }
         }
         _scollPanel.commitChanges();
         _scollPanel.invalidateViewport();
      }
      
      private function __updateViewHandler(param1:Event) : void
      {
         if(HeroRoadManager.instance.giftFrameHasOpen)
         {
            return;
         }
         __panelChangeHandler(null);
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(_group.selectIndex == 0)
         {
            _dataArray = HeroRoadManager.instance.getAllAchievemtnItems();
         }
         else
         {
            _dataArray = HeroRoadManager.instance.getAchievemtnItemsByClassify(_group.selectIndex);
         }
         refreshData(_dataArray);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_scollPanel);
         _scollPanel = null;
         ObjectUtils.disposeObject(_allAchievementBtn);
         _allAchievementBtn = null;
         ObjectUtils.disposeObject(_roleAchievementBtn);
         _roleAchievementBtn = null;
         ObjectUtils.disposeObject(_transcriptAchievementBtn);
         _transcriptAchievementBtn = null;
         ObjectUtils.disposeObject(_competitiveAchievementBtn);
         _competitiveAchievementBtn = null;
      }
   }
}

