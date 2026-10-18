package skytreasure.reward
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasureCoinRankFrame extends Frame implements IManualSize
   {
      
      public var _tabVbox:HBox;
      
      public var _btnList:SelectedButtonGroup;
      
      public var _view2:SkyTreasureCoinRankView;
      
      public var _view1:SkytreasurelunCoinRankView;
      
      private var _back:DisplayObject;
      
      private var _index:int = 1;
      
      public function SkyTreasureCoinRankFrame()
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
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,765,515);
      }
      
      private function initData() : void
      {
         var _loc4_:SelectedTextButton = null;
         var _loc3_:int = 0;
         _btnList = new SelectedButtonGroup();
         var _loc1_:Array = [LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tab1"),LanguageMgr.GetTranslation("SkyTreasureCoinRankFrame.tab2")];
         var _loc2_:int = int(_loc1_ ? _loc1_.length : 0);
         _tabVbox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("SkyTreasureCoinRankFrame.Btn1");
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
         _back.width = 735;
         _back.height = 400;
         _back.x = 0;
         _back.y = 30;
         _tabVbox = ComponentFactory.Instance.creatCustomObject("skyTreasure.otherHbox");
         addToContent(_tabVbox);
         _view1 = new SkytreasurelunCoinRankView();
         addToContent(_view1);
         _view2 = new SkyTreasureCoinRankView();
         _view2.visible = false;
         addToContent(_view2);
      }
      
      private function initEvent() : void
      {
         _btnList.addEventListener("change",__onTabClick);
         addEventListener("response",__frameResponse);
      }
      
      private function get model() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      private function __onTabClick(param1:Event) : void
      {
         var _loc2_:* = null;
         _index = param1.currentTarget.selectIndex + 1;
         if(_index == 1)
         {
            _view1.visible = true;
            _view2.visible = false;
         }
         else
         {
            _view1.visible = false;
            _view2.visible = true;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
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
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

