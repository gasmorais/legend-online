package oldbacker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.OldBackerEvents;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.OldBackerManager;
   import mvc.module.oldbacker.OldBackerModel;
   import oldbacker.item.OldBackerRewardItem;
   
   public class OldBackerRewardView extends Component
   {
      
      private var _titleBack:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _scroll:ScrollPanel;
      
      private var _typeView:int;
      
      public function OldBackerRewardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.oldbacker.FarmeBackRewardItemTitleBack");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewMsgText04");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("oldbacker.rewardVbox");
         _scroll = ComponentFactory.Instance.creatComponentByStylename("oldbacker.rewardScrollPanel");
         addChild(_titleBack);
         addChild(_timeTxt);
         addChild(_scroll);
         _scroll.setView(_vbox);
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:String = model.stopTime.substr(0,10);
         _timeTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText12",_loc1_);
         createList();
      }
      
      private function createList() : void
      {
         var _loc2_:OldBackerRewardItem = null;
         var _loc4_:int = 0;
         ObjectUtils.disposeAllChildren(_vbox);
         var _loc1_:Array = model.getViewInfoByType(model.currentType);
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new OldBackerRewardItem();
            _vbox.addChild(_loc2_);
            _loc2_.data = _loc1_[_loc4_];
            _loc4_ += 1;
         }
         _scroll.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         model.addEventListener("REFRESH_VIEW_INFO",__updataInfos);
      }
      
      private function __updataInfos(param1:OldBackerEvents) : void
      {
         refreshView();
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("REFRESH_VIEW_INFO",__updataInfos);
      }
      
      private function get model() : OldBackerModel
      {
         return OldBackerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeAllChildren(_vbox);
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scroll);
         _scroll = null;
         super.dispose();
      }
   }
}

