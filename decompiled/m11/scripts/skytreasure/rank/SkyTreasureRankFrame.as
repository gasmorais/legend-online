package skytreasure.rank
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasureRankFrame extends Frame implements IManualSize
   {
      
      public var _tabVbox:HBox;
      
      public var _btnList:SelectedButtonGroup;
      
      private var _act:SkyTreasureActTemplateInfo;
      
      public var _view1:SkyTreasurePersonalView;
      
      public var _view2:SkyTreasureHistoryView;
      
      private var _back:DisplayObject;
      
      private var _rewardsListScroll:ScrollPanel;
      
      private var _luckShowListScroll:ScrollPanel;
      
      private var _index:int = 1;
      
      public function SkyTreasureRankFrame()
      {
         super();
         initView();
         initData();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function show(param1:SkyTreasureActTemplateInfo) : void
      {
         _act = param1;
         titleText = LanguageMgr.GetTranslation("skyTreasure.rewardTXTTitle");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,545,505);
      }
      
      private function initData() : void
      {
         var _loc4_:SelectedTextButton = null;
         var _loc3_:int = 0;
         _btnList = new SelectedButtonGroup();
         var _loc1_:Array = [LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tab3"),LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tab4"),LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tab5")];
         var _loc2_:int = int(_loc1_ ? _loc1_.length : 0);
         _tabVbox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureCoinRankFrame.Btn");
            _loc4_.text = _loc1_[_loc3_];
            _loc4_.x = _loc3_ * (_loc4_.width + 20);
            _tabVbox.addChild(_loc4_);
            _btnList.addSelectItem(_loc4_);
            _loc3_++;
         }
         _tabVbox.commitChanges();
         _btnList.selectIndex = 0;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("secretary.view.SecretaryCompentView.back");
         addToContent(_back);
         _back.width = 520;
         _back.height = 370;
         _back.x = -5;
         _back.y = 35;
         _tabVbox = ComponentFactory.Instance.creatCustomObject("skyTreasure.otherHbox");
         _view1 = new SkyTreasurePersonalView();
         _view2 = new SkyTreasureHistoryView();
         addToContent(_view1);
         addToContent(_view2);
         _view1.y = 10;
         _view2.y = 40;
         _view1.refreshShowInfo();
         addToContent(_tabVbox);
         _view2.visible = false;
      }
      
      private function initEvent() : void
      {
         _btnList.addEventListener("change",__onTabClick);
         addEventListener("response",__frameResponse);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_RANKHISTORY_UPDATE",__onLotteryResult);
      }
      
      private function __onTabClick(param1:Event) : void
      {
         _index = param1.currentTarget.selectIndex + 1;
         __onLotteryResult();
      }
      
      private function __onLotteryResult(param1:SkyTreasureEvent = null) : void
      {
         switch(_index - 1)
         {
            case 0:
               _view1.visible = true;
               _view2.visible = false;
               _view1.refreshShowInfo();
               break;
            case 1:
               _view1.visible = true;
               _view2.visible = false;
               _view1.refreshShowInfo1();
               break;
            default:
               _view1.visible = false;
               _view2.visible = true;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         _btnList.removeEventListener("change",__onTabClick);
         removeEventListener("response",__frameResponse);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_RANKHISTORY_UPDATE",__onLotteryResult);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

