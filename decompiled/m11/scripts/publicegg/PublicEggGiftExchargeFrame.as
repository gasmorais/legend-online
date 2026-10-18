package publicegg
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.manager.PublicEggManager;
   
   public class PublicEggGiftExchargeFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _eggBtn:SelectedIconButton;
      
      private var _giftBtn:SelectedIconButton;
      
      private var _exchargeBtn:SelectedIconButton;
      
      private var _group1:SelectedButtonGroup;
      
      private var _tabView1:PublicEggView;
      
      private var _tabView2:PublicGiftView;
      
      private var _tabView3:PublicSummonView;
      
      public function PublicEggGiftExchargeFrame()
      {
         super();
         initView();
         addEvent();
         setSelectIndex();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,888,655);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("publicchairs.PublicEggGiftExchargeFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("publicegg.PublicEggGiftExchargeFrame.back");
         _eggBtn = ComponentFactory.Instance.creatComponentByStylename("publicegg.eggTabBtn");
         _giftBtn = ComponentFactory.Instance.creatComponentByStylename("publicegg.giftTabBtn");
         _exchargeBtn = ComponentFactory.Instance.creatComponentByStylename("publicegg.exchargeTabBtn");
         _group1 = new SelectedButtonGroup();
         _group1.addSelectItem(_eggBtn);
         _group1.addSelectItem(_giftBtn);
         _group1.addSelectItem(_exchargeBtn);
         addToContent(_back);
         addToContent(_eggBtn);
         addToContent(_giftBtn);
         addToContent(_exchargeBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_group1)
         {
            _group1.addEventListener("change",__tabChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_group1)
         {
            _group1.removeEventListener("change",__tabChangeHandler);
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         if(_tabView1)
         {
            ObjectUtils.disposeObject(_tabView1);
         }
         _tabView1 = null;
         if(_tabView2)
         {
            ObjectUtils.disposeObject(_tabView2);
         }
         _tabView2 = null;
         if(_tabView3)
         {
            ObjectUtils.disposeObject(_tabView3);
         }
         _tabView3 = null;
         if(_group1.selectIndex == 0)
         {
            _tabView1 = ComponentFactory.Instance.creatCustomObject("publicegg.PublicEggView");
            addToContent(_tabView1);
         }
         else if(_group1.selectIndex == 1)
         {
            _tabView2 = ComponentFactory.Instance.creatCustomObject("publicegg.PublicGiftView");
            addToContent(_tabView2);
         }
         else if(_group1.selectIndex == 2)
         {
            _tabView3 = ComponentFactory.Instance.creatCustomObject("publicegg.PublicSummonView");
            addToContent(_tabView3);
         }
      }
      
      private function setSelectIndex() : void
      {
         if(PublicEggManager.instance.openEgg1)
         {
            _group1.selectIndex = 0;
         }
         else if(PublicEggManager.instance.openGift1)
         {
            _group1.selectIndex = 1;
         }
         _eggBtn.enable = PublicEggManager.instance.openEgg1;
         _giftBtn.enable = PublicEggManager.instance.openGift1;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_group1);
         _group1 = null;
         ObjectUtils.disposeObject(_eggBtn);
         _eggBtn = null;
         ObjectUtils.disposeObject(_giftBtn);
         _giftBtn = null;
         ObjectUtils.disposeObject(_exchargeBtn);
         _exchargeBtn = null;
         ObjectUtils.disposeObject(_tabView1);
         _tabView1 = null;
         ObjectUtils.disposeObject(_tabView2);
         _tabView2 = null;
         ObjectUtils.disposeObject(_tabView3);
         _tabView3 = null;
         super.dispose();
      }
   }
}

